#include "subjectmodel.h"



SubjectModel::SubjectModel(QObject *parent)
{

}

//Εισαγωγή μαθήματος με βαθμούς
void SubjectModel::insertSubject(QString name,QString nameStudent,double test1,double test2,double test3)
{
    beginResetModel();
    Subject sub(name,nameStudent,test1,test2,test3); //δημιουργία ενός αντικειμένου Subject και πέρασμα των παραμέτρων που δίνει ο χρήστης.
    this->myData.push_back(sub); // παιρνάω το αντικείμενο που δημιούργησα στο vector όπου αποθηκέυω όλα τα μαθήματα που εισάγω (myData).
    endResetModel();

    qDebug("insertSubject called in Subject Model\n");
    qDebug("Size of vector is now %d\n",myData.size());
}

//διαγραφή μαθήματος
void SubjectModel::deleteSubject(int row){
    beginRemoveRows(QModelIndex(),row,row);
    myData.removeAt(row);
    endRemoveRows();
}

void SubjectModel::getSubject(int row, QString sname, QString snameStudent, double stest1, double stest2, double stest3){

    sname = myData[row].getName();
    snameStudent = myData[row].getNameStudent();
    stest1 = myData[row].getTestOne();
    stest2 = myData[row].getTestTwo();
    stest3 = myData[row].getTestThree();
}

//Καθορίζω τα properties των roles έτσι ώστε να μπορώ να τα χρησιμοποιώ στην qml
QHash<int, QByteArray> SubjectModel::roleNames() const{
    QHash<int, QByteArray> roles;
    roles[NameRole]="subName";
    roles[NameStudentRole]="studentOfSubject";
    roles[this->TestOneRole]="t1";
    roles[this->TestTwoRole]="t2";
    roles[this->TestThreeRole]="t3";
    roles[this->TestMO]="moTest"; //to allaksa

    return roles;
}




//the QModelIndex provides the row and column information for the cell, for which the view wants to retrieve data.
//rowCount : πλήθος των rows
int SubjectModel::rowCount(const QModelIndex &parent) const
{
    return myData.size();
}

QVariant SubjectModel::data(const QModelIndex &index, int role) const
{
    int row=index.row();
    if(myData.size()>row && row>=0)
    {
        Subject subject = myData[row]; //παίρνουμε από το row που επιλέγεται το αντίστοιχο αντικείμενο Subject
        switch(role)
        {
           case NameRole: return subject.getName();
           case NameStudentRole: return subject.getNameStudent();
           case TestOneRole: return subject.getTestOne();
           case TestTwoRole: return subject.getTestTwo();
           case TestThreeRole: return subject.getTestThree();
           case TestMO: return subject.getTestMO(); //to allaksa
        default:return QVariant();

        }
    }
    else
    {
        QVariant gv;
        return gv;
    }
}


QVariant SubjectModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role != Qt::DisplayRole)
        return QVariant();

    if (orientation == Qt::Horizontal)
    {
        switch (role)
        {
            case NameRole: return "Name";
        case NameStudentRole: return "Student";
            case TestOneRole: return "First Test  (%)";
            case TestTwoRole: return "Second Test(%)";
            case TestThreeRole: return "Third Test (%)";
            default: return QVariant();
        }
    }
    else
        return QString("Row %1").arg(section);
}

vector<pair<Subject *,double>> SubjectModel::convert(vector<QString> names, vector<double> grades) //δημιουργέι ένα vector με ζευγάρια (Μάθημα-MO)
{
    vector<pair<Subject *,double>> components;

    qDebug("in convert\n");

    for (unsigned long i=0;i<names.size();i++)
    {
        for (unsigned long j=0; j<myData.size();j++)
        {
            if ( ((Subject)myData[j]).getName()==names[i])
            {
                pair<Subject *,double> p(&myData[j],grades[i]);
                components.push_back(p);
                break;
            }
        }

    }
    qDebug("out of convert\n");
    return components;
}
