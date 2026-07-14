#!/bin/bash
set -e

echo "=== VCardSmart Test Script ==="
echo ""

# Navigate to app directory
cd "$(dirname "$0")/../app"

# Get dependencies
echo "1. Getting dependencies..."
flutter pub get

# Analyze
echo "2. Analyzing..."
flutter analyze

# Run tests
echo "3. Running tests..."
flutter test

# Run tests with coverage
echo "4. Running tests with coverage..."
flutter test --coverage

echo ""
echo "=== Tests Complete ==="
echo "Coverage report: coverage/lcov.info"
