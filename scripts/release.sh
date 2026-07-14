#!/bin/bash
set -e

echo "=== VCardSmart Release Script ==="
echo ""

# Navigate to app directory
cd "$(dirname "$0")/../app"

# Check arguments
VERSION=${1:-"1.0.0"}
BUILD_NUMBER=${2:-"1"}

echo "Version: $VERSION"
echo "Build Number: $BUILD_NUMBER"
echo ""

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

# Run tests
echo "5. Running tests..."
flutter test

# Build Android
echo "6. Building Android..."
flutter build apk --release --build-name=$VERSION --build-number=$BUILD_NUMBER
flutter build appbundle --release --build-name=$VERSION --build-number=$BUILD_NUMBER

# Build iOS
echo "7. Building iOS..."
flutter build ios --release --build-name=$VERSION --build-number=$BUILD_NUMBER

echo ""
echo "=== Release Complete ==="
echo "APK: build/app/outputs/flutter-apk/app-release.apk"
echo "AAB: build/app/outputs/bundle/release/app-release.aab"
echo "IPA: build/ios/iphoneos/Runner.app"
