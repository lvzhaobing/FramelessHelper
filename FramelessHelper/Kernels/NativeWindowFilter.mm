#include "NativeWindowFilter.h"
#include "NativeWindowFilter_p.h"
#include <QCoreApplication>
#include "NativeWindowHelper_p.h"

// class NativeWindowFilter

void NativeWindowFilter::deliver(QWindow *window, NativeWindowHelper *helper)
{
    Q_CHECK_PTR(window);

    if (!NativeWindowFilterPrivate::instance) {
        QCoreApplication *appc = QCoreApplication::instance();
        if (appc) {
            auto filter = new NativeWindowFilter();
            NativeWindowFilterPrivate::instance.reset(filter);
            appc->installNativeEventFilter(filter);
        }
    }

    if (helper) {
        WId newId = window->winId();
        WId oldId = NativeWindowFilterPrivate::windows.value(helper);
        if (newId != oldId) {
            NativeWindowFilterPrivate::helpers.insert(newId, helper);
            NativeWindowFilterPrivate::helpers.remove(oldId);
            NativeWindowFilterPrivate::windows.insert(helper, newId);

            NativeWindowFilterPrivate::winIds.insert(window, newId);
        }
    } else {
        WId oldId = NativeWindowFilterPrivate::winIds.take(window);
        NativeWindowHelper *helper = NativeWindowFilterPrivate::helpers.take(oldId);
        NativeWindowFilterPrivate::windows.remove(helper);
    }
}

bool NativeWindowFilter::nativeEventFilter(const QByteArray &eventType,
                                           void *message, long *result)
{
    Q_UNUSED(eventType);

    return false;
}

// class NativeWindowFilterPrivate

QScopedPointer<NativeWindowFilter> NativeWindowFilterPrivate::instance;

QHash<NativeWindowHelper *, WId> NativeWindowFilterPrivate::windows;
QHash<QWindow *, WId> NativeWindowFilterPrivate::winIds;
QHash<WId, NativeWindowHelper *> NativeWindowFilterPrivate::helpers;
