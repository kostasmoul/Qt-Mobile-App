#ifndef STUDENT_H
#define STUDENT_H
#include <QObject>
#include "subject.h"


using namespace std;

class Student
{

private:
    QString studentName;
    QString imgPath;
    QString observations;    
    double mesos_oros; //new
public:
    Student(QString studentName,QString imgPath,QString observations,double mesos_oros);
    Student(QString studentName,QString imgPath,QString observations);


    QString getName(){return studentName;}
    QString getObservations(){return observations;}
    QString getImgPath(){return imgPath;}


    double getMO(){return mesos_oros;}




};

#endif // STUDENT_H
