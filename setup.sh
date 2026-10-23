#!/usr/bin/env bash
set -euo pipefail

# ------------------ Configuration (edit per semester) ------------------
source "$(dirname "$0")/config.sh"
# -----------------------------------------------------------------------

VENV_DIR="$VENV_ROOT/$VENV_NAME"
VENV_PY="$VENV_DIR/bin/python"

# 1. Install uv if missing (user-level, no admin rights)
export PATH="$HOME/.local/bin:$PATH"
if ! command -v uv >/dev/null 2>&1; then
  if command -v curl >/dev/null 2>&1; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
  else
    wget -qO- https://astral.sh/uv/install.sh | sh
  fi
fi

# 2. Create the environment (reuse it if it already exists)
# --seed installs pip in the venv
mkdir -p "$VENV_ROOT"
if [ -x "$VENV_PY" ]; then
  echo "Environment $VENV_DIR already exists, reusing it."
else
  uv venv --seed --python "$PYTHON_VERSION" "$VENV_DIR"
fi

# 3. Install the requirements
uv pip install \
    --python "$VENV_PY" \
    --build-constraint <(echo "setuptools<81") \
    -r "$REQUIREMENTS"

# 4. Register the Jupyter kernel for VS Code
if [ "$REGISTER_KERNEL" = "1" ]; then
  "$VENV_PY" -m ipykernel install --user --name "$VENV_NAME" \
      --display-name "Python $PYTHON_VERSION ($VENV_NAME)"
fi

# 5. Check
"$VENV_PY" -c "import qiskit; print('Qiskit', qiskit.__version__)"
echo
echo "Installation completed"
echo "Environment: $VENV_DIR"
echo "Kernel:      $KERNEL_DISPLAY"
echo
echo "To uninstall, run the provided uninstall.sh script, 'bash uninstall.sh'" 
echo "Alternatively, remove the venv: rm -rf \"$VENV_DIR\""
