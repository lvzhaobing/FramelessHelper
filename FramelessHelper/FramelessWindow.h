#ifndef FRAMELESSWINDOW_H
#define FRAMELESSWINDOW_H

#include <QQuickWindow>

class FramelessWindow : public QQuickWindow
{
    Q_OBJECT

    Q_PROPERTY(bool movable READ movable WRITE setMovable NOTIFY movableChanged)
    Q_PROPERTY(bool resizable READ resizable WRITE setResizable NOTIFY resizableChanged)
    Q_PROPERTY(int titleBarHeight READ titleBarHeight WRITE setTitleBarHeight NOTIFY titleBarHeightChanged)

    enum MouseArea {
        TopLeft = 1,
        Top,
        TopRight,
        Left,
        Move,
        Right,
        BottomLeft,
        Bottom,
        BottomRight,
        Client
    };

public:
    explicit FramelessWindow(QWindow *parent = nullptr);

    bool movable() const;
    void setMovable(bool arg);

    bool resizable() const;
    void setResizable(bool arg);

    int titleBarHeight() const;
    void setTitleBarHeight(int arg);

protected:
    void mousePressEvent(QMouseEvent *event) override;
    void mouseReleaseEvent(QMouseEvent *event) override;
    void mouseDoubleClickEvent(QMouseEvent *event) override;
    void mouseMoveEvent(QMouseEvent *event) override;

signals:
    void movableChanged();
    void resizableChanged();
    void titleBarHeightChanged();

private:
    MouseArea getArea(const QPoint &pos);
    void setWindowGeometry(const QPoint &pos);
    void setCursorIcon();
    void set_geometry_func (const QSize &size, const QPoint &pos);

    bool m_movable = true;
    bool m_resizable = true;
    int m_titltBarHeight = 28;

    MouseArea m_currentArea = Move;
    QPoint m_startPos;
    QPoint m_oldPos;
    QSize m_oldSize;
};

#endif
