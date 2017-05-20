#ifndef MESSAGE_H
#define MESSAGE_H
#include <QObject>
#include "studentmodel.h"
#include "subjectmodel.h"


class Message : public QObject
{
     Q_OBJECT
    Q_PROPERTY(SubjectModel* subjectModel READ subjectModel WRITE setSubjectModel NOTIFY subjectModelChanged)
    Q_PROPERTY(StudentModel* studentModel READ studentModel WRITE setStudentModel NOTIFY studentModelChanged)


public:
    Message(QObject *parent=0);
    void setSubjectModel(SubjectModel* m)
    {
        _subjectModel=m;
        emit subjectModelChanged();
    }
    void setStudentModel(StudentModel* m)
    {
        _studentModel=m;
        emit studentModelChanged();
    }

    SubjectModel* subjectModel()
    {
        return _subjectModel;
    }

    StudentModel* studentModel()
    {
        return _studentModel;
    }
private:
    SubjectModel* _subjectModel;
    StudentModel* _studentModel;

signals:
    void subjectModelChanged();
    void studentModelChanged();

public slots:
    void insertStudent(QString name,QString imgPath,QString observations,double mo);
    void insertSubject(QString name,QString nameStudent,double test1,double test2,double test3);
    double computeFinalMO(QVariantList names, QVariantList grades);
    void deleteStudent(int row);
    void deleteSubject(int row);
    void test(){}
};

#endif // MESSAGE_H
