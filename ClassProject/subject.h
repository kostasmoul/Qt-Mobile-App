#ifndef SUBJECT_H
#define SUBJECT_H
#include <QObject>

class Subject
{
private:
    QString name;
    QString nameOfStudent;
    double testOneGrade;
    double testTwoGrade;
    double testThreeGrade;
public:
    Subject(QString name,QString student, double t1, double t2, double t3);
    QString getName() const;
    QString getNameStudent() const;
    double getTestOne() const {return testOneGrade;}
    double getTestTwo() const {return testTwoGrade;}
    double getTestThree() const {return testThreeGrade;}
    double getTestMO() const {return ((testOneGrade + testTwoGrade + testThreeGrade)/3.0); }



};

#endif // SUBJECT_H
