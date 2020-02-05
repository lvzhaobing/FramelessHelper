INCLUDEPATH += $$PWD

win32 {
    QT += winextras
    LIBS += -lUser32
SOURCES += \
    $$PWD/Kernels/NativeWindowHelper.cpp
}

macx {
SOURCES += \
    $$PWD/Kernels/NativeWindowHelper.mm
}


HEADERS += \
    $$PWD/FramelessHelper.h \
    $$PWD/FramelessHelper_p.h \
    $$PWD/WindowFramelessHelper.h \
    $$PWD/WindowFramelessHelper_p.h
SOURCES += \
    $$PWD/FramelessHelper.cpp \
    $$PWD/WindowFramelessHelper.cpp

HEADERS += \
    $$PWD/Kernels/NativeWindowFilter.h \
    $$PWD/Kernels/NativeWindowFilter_p.h \
    $$PWD/Kernels/NativeWindowHelper.h \
    $$PWD/Kernels/NativeWindowHelper_p.h
SOURCES += \
    $$PWD/Kernels/NativeWindowFilter.cpp

