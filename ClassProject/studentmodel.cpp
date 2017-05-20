#include "studentmodel.h"

StudentModel::StudentModel()
{


}

double StudentModel::getTheMO(vector<pair<Subject*,double>> comp){
    double sum=0.0;
    for (int i=0;i<comp.size();i++){
        sum+=comp[i].second;
    }
    double mesos= sum/comp.size();
    return mesos;

}

void StudentModel::insertStudent(QString name,QString imgPath,QString observations,double mo)
{
    qDebug ("in insertStudent\n");
//    beginResetModel();
 beginInsertRows(QModelIndex(), rowCount(), rowCount());
    Student *st;
    st=new Student(name,imgPath,observations,mo);
     qDebug ("object created\n");
//     this->myData.push_back(*st);
     myData<<*st;
     endInsertRows();
//     endResetModel();

     qDebug("insertStudent called in Student Model\n");
     qDebug("Size of vector is now %d\n",myData.size());

}


void StudentModel::deleteStudent(int row){
    beginRemoveRows(QModelIndex(),row,row);
    myData.removeAt(row);
    endRemoveRows();
}


void StudentModel::getStudent(int row, QString &sname, QString &simgPath, QString &sobservations, double smo){

    sname= myData[row].getName();
    simgPath= myData[row].getImgPath();
    sobservations= myData[row].getObservations();
    smo= myData[row].getMO();
}

QHash<int, QByteArray> StudentModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole]="studentName";
    roles[ImgPathRole]="image";
    roles[ObservationsRole]="observations";
    roles[MoRole]="moStudent";
    return roles;

}

int StudentModel::rowCount(const QModelIndex &parent) const
{
    return myData.size();
}

QVariant StudentModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if (myData.size()>row && row>=0)
    {
        Student i=myData[row];

        switch (role)
        {
          case NameRole: return i.getName();
          case ObservationsRole:return i.getObservations();
          case ImgPathRole:return i.getImgPath();
          case MoRole:return i.getMO();
         default: return QVariant();
        }
    }
    else
    {
        QVariant qv;
        return qv;
    }
}
