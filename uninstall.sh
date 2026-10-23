#!/usr/bin/env bash
set -euo pipefail

# ---- Configuration (must match setup.sh) ------------------------------
source "$(dirname "$0")/config.sh"
# -----------------------------------------------------------------------

VENV_DIR="$VENV_ROOT/$VENV_NAME"
VENV_PY="$VENV_DIR/bin/python"

# Location of user-level kernelspecs (used as a fallback)
if [ -n "${JUPYTER_DATA_DIR:-}" ]; then
  KERNEL_DIR="$JUPYTER_DATA_DIR/kernels/$KERNEL_NAME"
elif [ "$(uname -s)" = "Darwin" ]; then
  KERNEL_DIR="$HOME/Library/Jupyter/kernels/$KERNEL_NAME"
else
  KERNEL_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/jupyter/kernels/$KERNEL_NAME"
fi

echo "This will remove:"
echo "  - Jupyter kernel: $KERNEL_NAME"
echo "  - Environment:    $VENV_DIR"
read -r -p "Continue? [y/N] " answer
case "$answer" in
  [yY]|[yY][eE][sS]) ;;
  *) echo "Aborted."; exit 0 ;;
esac

# 1. Deregister the kernel (before the venv disappears)
if [ -x "$VENV_PY" ] && "$VENV_PY" -m jupyter kernelspec remove -f "$KERNEL_NAME" 2>/dev/null; then
  echo "Kernel $KERNEL_NAME deregistered."
elif [ -d "$KERNEL_DIR" ]; then
  rm -rf "$KERNEL_DIR"
  echo "Kernel directory removed: $KERNEL_DIR"
else
  echo "No registered kernel named $KERNEL_NAME found."
fi

# 2. Remove the environment (refuse suspicious paths)
case "$VENV_DIR" in
  "$HOME"/?*/?*)
    if [ -d "$VENV_DIR" ]; then
      rm -rf "$VENV_DIR"
      echo "Environment removed: $VENV_DIR"
    else
      echo "No environment found at $VENV_DIR."
    fi ;;
  *)
    echo "Refusing to delete unexpected path: $VENV_DIR"; exit 1 ;;
esac

echo
echo "Done. In VS Code, run 'Developer: Reload Window' so the kernel list refreshes."
