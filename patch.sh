#!/usr/bin/env bash
PATCHED=false

if "$PATCHED"; then
    echo "🎉 Already patched"
else
    case "$(uname)" in
        Darwin)
            echo "✨ No patches needed on macOS"
            ;;
        Linux)
            echo "🔧 Applying Linux patches..."
            patch ./Makefile       < ./patches/linux/makefile.patch
            patch ./src/macros.inc < ./patches/linux/macros.patch
            patch ./src/main.asm   < ./patches/linux/main.patch
            patch ./patch.sh       < ./patches/patch.patch
            ;;
        *)
            echo "❌ Platform not supported..."
            echo "🔧 Please submit a PR to add support for this platform"
            exit 1
            ;;
    esac
fi
