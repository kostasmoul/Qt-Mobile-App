#include "message.h"
#include <QFile>
#include <QStandardPaths>
#include <QTextStream>



Message::Message(QObject *parent): QObject(parent)
{
    _subjectModel= new SubjectModel();
    _studentModel=new StudentModel();
/**
    insertSubject("History","Katerina",8.2,6.3,7.4);
    insertSubject("Math","Katerina",3.2,4.2,2.4);
    insertSubject("Economics","Katerina",3.3,6.7,7.3);

    QVariantList s;
    s.append("History");
    s.append("Math");
    s.append("Economics");

    QVariantList g;
    g.append(7.3); //MO των 8.2, 6.3, 7.4 απο πάνω
    g.append(3.2);   //ΜΟ των 3.2, 4.2, 2.4
    g.append(5.7);


    double mo = computeFinalMO(s,g);
    insertStudent("Katerina","images/profile.png","Some Observations...",mo);
  **/

    QString st1 ="students.txt"; //new


    QFile qf(st1);
    qf.open(QIODevice::ReadOnly | QIODevice::Text);

    QTextStream in(&qf);
    while (!in.atEnd())
    {
        QString sname = in.readLine();
        QString simg = in.readLine();
        QString sobs = in.readLine();
        QString smo = in.readLine();
        double mo= smo.toDouble();
        _studentModel->insertStudent(sname,simg,sobs,mo);
    }
    qf.close(); //end new

    //new*********
    QString st2="subjects.txt";
    QFile qf2(st2);
    qf2.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream in2(&qf2);
    while (!in2.atEnd())
    {
        QString sname = in2.readLine();
        QString snameStudent = in2.readLine();
        QString stest1 = in2.readLine();
        QString stest2 = in2.readLine();
        QString stest3 = in2.readLine();
        double test1= stest1.toDouble();
        double test2= stest2.toDouble();
        double test3= stest3.toDouble();
        _subjectModel->insertSubject(sname,snameStudent,test1,test2,test3);
    }
    qf2.close();
    //end new *******




}


void Message::insertSubject(QString name,QString nameStudent, double test1, double test2, double test3)
{

    //new
        QString st ="subjects.txt";
        QFile qf(st);
        QTextStream out(&qf);

        qf.open(QIODevice::Append | QIODevice::Text);

        out<<name<<endl;
        out<<nameStudent<<endl;
        out<<test1<<endl;
        out<<test2<<endl;
        out<<test3<<endl;
        qf.close();

    //end new
    _subjectModel->insertSubject(name,nameStudent,test1,test2,test3);
    emit subjectModelChanged();
    qDebug("InsertSubject called in Msg\n");
}

double Message::computeFinalMO(QVariantList names, QVariantList grades){

    //first we convert
    vector<QString> theNames;
    vector<double> theGrades;

    for (int i=0;i<names.size();i++)
        theNames.push_back(names[i].toString());

    for (int i=0;i<grades.size();i++)
        theGrades.push_back(grades[i].toDouble());

    vector<pair<Subject*,double>> comp;
   comp = _subjectModel->convert(theNames,theGrades);
  double mesosOros= _studentModel->getTheMO(comp);
  return mesosOros;

}

void Message::insertStudent(QString name,QString imgPath,QString observations,double mo)
{
    qDebug("In insertStudent\n");
//new
    QString st ="students.txt";
    QFile qf(st);
    QTextStream out(&qf);

    qf.open(QIODevice::Append | QIODevice::Text);

    out<<name<<endl;
    out<<imgPath<<endl;
    out<<observations<<endl;
    out<<mo<<endl;
    qf.close();

//end new

    _studentModel->insertStudent(name,imgPath,observations,mo);


}

void Message::deleteStudent(int row){
    _studentModel->deleteStudent(row);
    QString file="students.txt";
    QFile qf(file);
    QTextStream out(&qf);

    qf.open(QIODevice::WriteOnly | QIODevice::Text);
    for(int i=0; i<_studentModel->rowCount();i++){
        QString name,img,obs;
        double mo;
        _studentModel->getStudent(i,name,img,obs,mo);
        out<<name<<endl;
        out<<img<<endl;
        out<<obs<<endl;
        out<<mo<<endl; //it prints to the file the list after we have deleted the student from the list
    }
    qf.close();

}

void Message::deleteSubject(int row){
    _subjectModel->deleteSubject(row); //διαγραφή της γραμμής row από το myData.
    QString file="subjects.txt";
    QFile qf(file);
    QTextStream out(&qf);

    qf.open(QIODevice::WriteOnly | QIODevice::Text);
    for(int i=0;i<_subjectModel->rowCount();i++){
        QString name,nameStudent;
        double test1,test2,test3;
        _subjectModel->getSubject(i,name,nameStudent,test1,test2,test3); // η συνάρτηση getSubject επιστρέφει στις μεταβλητές που περνάμε ως ορίσματα τα στοιχεία του μαθήματος της i Γραμμής sto myData του SubjectModel.
        out<<name<<endl;
        out<<nameStudent<<endl;
        out<<test1<<endl;
        out<<test2<<endl;
        out<<test3<<endl;
    }
    qf.close();

}
