#pragma once

#ifdef _MSC_VER
// Windows
#include <windows.h>
#define PATH(x) L ## x

#else
// Linux definitions
#define DWORD uint32_t
#define HANDLE int
#define PVOID void *
#define PATH(x) x

#endif

#include <string>
#include <filesystem>
namespace fs = std::filesystem;

DWORD readFromSerial(PVOID lpParam);
void writePacket(HANDLE h, int address, const void* data, size_t data_size);
HANDLE openSerialPort(fs::path serial, int baudrate);

#ifdef _MSC_VER
static std::wstring s2ws(const std::string& str)
{
    int size_needed = MultiByteToWideChar(CP_UTF8, 0, &str[0], (int)str.size(), NULL, 0);
    std::wstring wstrTo(size_needed, 0);
    MultiByteToWideChar(CP_UTF8, 0, &str[0], (int)str.size(), &wstrTo[0], size_needed);
    return wstrTo;
}
#endif

extern char font8x8_basic[128][8];