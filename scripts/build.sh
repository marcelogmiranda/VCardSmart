#!/bin/bash
set -e

echo "=== VCardSmart Build Script ==="
echo ""

# Navigate to app directory
cd "$(dirname "$0")/../app"

# Clean
echo "1. Cleaning..."
flutter clean

# Get dependencies
echo "2. Getting dependencies..."
flutter pub get

# Run code generation
echo "3. Running code generation..."
dart run build_runner build --delete-conflicting-outputs

# Analyze
echo "4. Analyzing..."
flutter analyze

# Build APK
echo "5. Building APK..."
flutter build apk --release

echo ""
echo "=== Build Complete ==="
echo "APK: build/app/outputs/flutter-apk/app-release.apk"
