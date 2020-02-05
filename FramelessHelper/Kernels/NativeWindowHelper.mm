#include "NativeWindowHelper.h"
#include "NativeWindowHelper_p.h"

#include <QScreen>
#include <QEvent>

#include <QOperatingSystemVersion>

#include "NativeWindowFilter.h"

// class NativeWindowHelper

NativeWindowHelper::NativeWindowHelper(QWindow *window, NativeWindowTester *tester)
    : QObject(window)
    , d_ptr(new NativeWindowHelperPrivate())
{
    d_ptr->q_ptr = this;

    Q_D(NativeWindowHelper);

    Q_CHECK_PTR(window);
    Q_CHECK_PTR(tester);

    d->window = window;
    d->tester = tester;

    if (d->window) {
        d->scaleFactor = d->window->screen()->devicePixelRatio();

        if (d->window->flags() & Qt::FramelessWindowHint) {
            d->window->installEventFilter(this);
            d->updateWindowStyle();
        }
    }
}

NativeWindowHelper::NativeWindowHelper(QWindow *window)
    : QObject(window)
    , d_ptr(new NativeWindowHelperPrivate())
{
    d_ptr->q_ptr = this;

    Q_D(NativeWindowHelper);

    Q_CHECK_PTR(window);
    d->window = window;

    if (d->window) {
        d->scaleFactor = d->window->screen()->devicePixelRatio();

        if (d->window->flags() & Qt::FramelessWindowHint) {
            d->window->installEventFilter(this);
            d->updateWindowStyle();
        }
    }
}

NativeWindowHelper::~NativeWindowHelper()
{
}

bool NativeWindowHelper::nativeEventFilter(void *msg, long *result)
{
    Q_D(NativeWindowHelper);

    Q_CHECK_PTR(d->window);

    return false;
}

bool NativeWindowHelper::eventFilter(QObject *obj, QEvent *ev)
{
    Q_D(NativeWindowHelper);

    if (ev->type() == QEvent::WinIdChange) {
        d->updateWindowStyle();
    } else if (ev->type() == QEvent::Show) {
        d->updateWindowStyle();
    }

    return QObject::eventFilter(obj, ev);
}

qreal NativeWindowHelper::scaleFactor() const
{
    Q_D(const NativeWindowHelper);

    return d->scaleFactor;
}

// class NativeWindowHelperPrivate

NativeWindowHelperPrivate::NativeWindowHelperPrivate()
    : q_ptr(nullptr)
    , window(nullptr)
    , tester(nullptr)
    , scaleFactor(1.0)
    #ifdef Q_OS_WIN
    , oldWindow(NULL)
    #endif
{
}

NativeWindowHelperPrivate::~NativeWindowHelperPrivate()
{
    if (window)
        NativeWindowFilter::deliver(window, nullptr);
}

void NativeWindowHelperPrivate::updateWindowStyle()
{
    Q_Q(NativeWindowHelper);
    Q_CHECK_PTR(window);

}

int NativeWindowHelperPrivate::hitTest(int x, int y) const
{
    Q_CHECK_PTR(window);
}

bool NativeWindowHelperPrivate::isMaximized() const
{
    Q_CHECK_PTR(window);
    return false;
}

QMargins NativeWindowHelperPrivate::draggableMargins() const
{
    return tester ? tester->draggableMargins() * scaleFactor : QMargins();
}

QMargins NativeWindowHelperPrivate::maximizedMargins() const
{
    return tester ? tester->maximizedMargins() * scaleFactor : QMargins();
}

QRect NativeWindowHelperPrivate::availableGeometry() const
{
    return QRect(0,0,0,0);
}
