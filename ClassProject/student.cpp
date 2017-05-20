#include "student.h"
#include <cmath>

Student::Student(QString studentName,QString imgPath,QString observations,double mesos_oros)
{
    this->studentName=studentName;
    this->observations=observations;
    this->imgPath=imgPath;
    this->mesos_oros=mesos_oros;

}
Student::Student(QString studentName, QString imgPath, QString observations)
{
    this->studentName=studentName;
    this->imgPath=imgPath;
    this->observations=observations;

}
