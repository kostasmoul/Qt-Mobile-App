#ifndef STUDENTMODEL_H
#define STUDENTMODEL_H
#include <QObject>
#include <QAbstractListModel>
#include "student.h"

class StudentModel: public QAbstractListModel
{
    Q_OBJECT
     QList <Student> myData;
public:
     enum SubjectRoles{
         NameRole=Qt::UserRole + 1,
         ObservationsRole,ImgPathRole,MoRole
     };

    StudentModel();
    void insertStudent(QString name,QString imgPath,QString observations,double mo);
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    double getTheMO(vector<pair<Subject*,double>> comp);
    void getStudent(int row,QString &sname,QString &simgPath, QString &sobservations,double smo);
    void deleteStudent(int row);

};

#endif // STUDENTMODEL_H
