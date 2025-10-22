#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BLUE='\033[0;34m'

echo -e "${BLUE}Starting test suite...${NC}\n"

# Run unit tests with coverage
echo -e "${BLUE}Running unit tests...${NC}"
flutter test test/unit --coverage
UNIT_RESULT=$?

# Run widget tests
echo -e "\n${BLUE}Running widget tests...${NC}"
flutter test test/widget
WIDGET_RESULT=$?

# Run integration tests
echo -e "\n${BLUE}Running integration tests...${NC}"
flutter test integration_test
INTEGRATION_RESULT=$?

# Generate coverage report
echo -e "\n${BLUE}Generating coverage report...${NC}"
genhtml coverage/lcov.info -o coverage/html

# Open coverage report
echo -e "\n${BLUE}Opening coverage report...${NC}"
if [[ "$OSTYPE" == "darwin"* ]]; then
    open coverage/html/index.html
elif [[ "$OSTYPE" == "msys" ]]; then
    start coverage/html/index.html
else
    xdg-open coverage/html/index.html
fi

# Check if all tests passed
if [ $UNIT_RESULT -eq 0 ] && [ $WIDGET_RESULT -eq 0 ] && [ $INTEGRATION_RESULT -eq 0 ]; then
    echo -e "\n${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "\n${RED}Some tests failed!${NC}"
    exit 1
fi