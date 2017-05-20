#include "subject.h"

Subject::Subject(QString name,QString nameStudent, double t1, double t2, double t3)   //αυτά θα τα βάζει ο χρήστης(δάσκαλος).
{
    this->name=name;
    this->nameOfStudent=nameStudent;
    this->testOneGrade=t1;
    this->testTwoGrade=t2;
    this->testThreeGrade=t3;

}

QString Subject::getName() const
{
    return name;
}


QString Subject::getNameStudent() const
{
    return nameOfStudent;
}
