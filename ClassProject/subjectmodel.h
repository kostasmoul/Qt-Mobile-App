#ifndef SUBJECTMODEL_H
#define SUBJECTMODEL_H
#include <QObject>
#include <QAbstractListModel>
#include "subject.h"

using namespace std;

class SubjectModel : public QAbstractListModel
{
    Q_OBJECT
public:

    enum SubjectRoles{
        NameRole=Qt::UserRole + 1,
        NameStudentRole,TestOneRole,TestTwoRole,TestThreeRole,TestMO //to allaksa
    };
    QHash<int, QByteArray> roleNames() const;

    SubjectModel(QObject *parent = 0);

     int rowCount(const QModelIndex &parent = QModelIndex()) const;
     QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

     void insertSubject(QString name,QString nameStudent,double test1,double test2,double test3);
     void deleteSubject(int row);
     void getSubject(int row,QString sname,QString snameStudent,double stest1,double stest2,double stest3);

     QVariant headerData(int section, Qt::Orientation orientation, int role) const;


     vector<pair<Subject *,double>> convert(vector<QString> names, vector<double> grades); //vector< pair<Subject *,double> > this is the return type..ζεύγοι μαθημάτων - βαθμών(βγαίνει τελικός βαθμός από τα 3 τεστ για κάθε μάθημα).
private:
     QList <Subject> myData; //στο myData θ αποθηκεύονται τα μαθήματα.



};

#endif // SUBJECTMODEL_H
