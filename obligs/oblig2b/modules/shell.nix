{ ... }: {
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        python3
        procps
        xdg-utils
      ];
      shellHook = ''
        cleanup_data2500() {
          if [ -n "''${watch_pid:-}" ]; then
            watch_pgid=$(ps -o pgid= -p "$watch_pid" 2>/dev/null | tr -d '[:space:]' || true)
            shell_pgid=$(ps -o pgid= -p "$$" 2>/dev/null | tr -d '[:space:]' || true)

            if [ -n "$watch_pgid" ] && [ "$watch_pgid" != "$shell_pgid" ]; then
              kill -TERM -- "-$watch_pgid" 2>/dev/null || true
            fi

            pkill -TERM -P "$watch_pid" 2>/dev/null || true
            kill "$watch_pid" 2>/dev/null || true
            pkill -KILL -P "$watch_pid" 2>/dev/null || true
            wait "$watch_pid" 2>/dev/null || true
          fi
          if [ -n "''${serve_pid:-}" ]; then
            kill "$serve_pid" 2>/dev/null || true
            wait "$serve_pid" 2>/dev/null || true
          fi
        }

        trap cleanup_data2500 EXIT INT TERM

        python serve.py >/tmp/data2500-serve.log 2>&1 &
        serve_pid=$!

        nix run .#watch >/tmp/data2500-watch.log 2>&1 &
        watch_pid=$!

        echo "Viewer + watch started in background."
        echo "Logs: /tmp/data2500-serve.log, /tmp/data2500-watch.log"
      '';
    };
  };
}