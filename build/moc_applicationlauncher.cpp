/****************************************************************************
** Meta object code from reading C++ file 'applicationlauncher.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.0.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../applicationlauncher.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'applicationlauncher.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.0.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_ApplicationLauncher_t {
    QByteArrayData data[7];
    char stringdata[77];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_ApplicationLauncher_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_ApplicationLauncher_t qt_meta_stringdata_ApplicationLauncher = {
    {
QT_MOC_LITERAL(0, 0, 19),
QT_MOC_LITERAL(1, 20, 12),
QT_MOC_LITERAL(2, 33, 0),
QT_MOC_LITERAL(3, 34, 16),
QT_MOC_LITERAL(4, 51, 6),
QT_MOC_LITERAL(5, 58, 7),
QT_MOC_LITERAL(6, 66, 9)
    },
    "ApplicationLauncher\0launchScript\0\0"
    "launchwaitScript\0getSTD\0appName\0"
    "arguments\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ApplicationLauncher[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       2,   32, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    0,   29,    2, 0x02,
       3,    0,   30,    2, 0x02,
       4,    0,   31,    2, 0x02,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,

 // properties: name, type, flags
       5, QMetaType::QString, 0x00095103,
       6, QMetaType::QString, 0x00095103,

       0        // eod
};

void ApplicationLauncher::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        ApplicationLauncher *_t = static_cast<ApplicationLauncher *>(_o);
        switch (_id) {
        case 0: _t->launchScript(); break;
        case 1: _t->launchwaitScript(); break;
        case 2: { QString _r = _t->getSTD();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObject ApplicationLauncher::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ApplicationLauncher.data,
      qt_meta_data_ApplicationLauncher,  qt_static_metacall, 0, 0}
};


const QMetaObject *ApplicationLauncher::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ApplicationLauncher::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ApplicationLauncher.stringdata))
        return static_cast<void*>(const_cast< ApplicationLauncher*>(this));
    return QObject::qt_metacast(_clname);
}

int ApplicationLauncher::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 3;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = appName(); break;
        case 1: *reinterpret_cast< QString*>(_v) = arguments(); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setAppName(*reinterpret_cast< QString*>(_v)); break;
        case 1: setArguments(*reinterpret_cast< QString*>(_v)); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 2;
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        if (_id < 2)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 2;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}
QT_END_MOC_NAMESPACE
