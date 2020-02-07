INCLUDEPATH += $$PWD

win32 {
    QT += winextras
    LIBS += -lUser32
SOURCES += \
    $$PWD/Kernels/NativeWindowFilter.cpp \
    $$PWD/Kernels/NativeWindowHelper.cpp
}

macx {
SOURCES += \
    $$PWD/Kernels/NativeWindowFilter.mm \
    $$PWD/Kernels/NativeWindowHelper.mm
}

linux {
SOURCES += \
    $$PWD/Kernels/NativeWindowFilter.cc \
    $$PWD/Kernels/NativeWindowHelper.cc
}

HEADERS += \
    $$PWD/FramelessHelper.h \
    $$PWD/FramelessHelper_p.h \
    $$PWD/FramelessWindow.h \
    $$PWD/WindowFramelessHelper.h \
    $$PWD/WindowFramelessHelper_p.h
SOURCES += \
    $$PWD/FramelessHelper.cpp \
    $$PWD/FramelessWindow.cpp \
    $$PWD/WindowFramelessHelper.cpp

HEADERS += \
    $$PWD/Kernels/NativeWindowFilter.h \
    $$PWD/Kernels/NativeWindowFilter_p.h \
    $$PWD/Kernels/NativeWindowHelper.h \
    $$PWD/Kernels/NativeWindowHelper_p.h

