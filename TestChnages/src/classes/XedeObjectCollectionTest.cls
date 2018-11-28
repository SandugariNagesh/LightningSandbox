@Istest
Public class XedeObjectCollectionTest{

Static Testmethod void XedeObjectCollMethode()
{

    list<XedeObject> objectList = new list<XedeObject>();
    list<XedeObject> dependentList = new list<XedeObject>();
    XedeObject Xobject=new XedeObject();
    
    list<sobject> sobjectList=new list<sobject>();
    
    XedeObjectCollection a=new XedeObjectCollection();
    
    a.saveTo(sobjectList,dependentList);
    a.add(Xobject);
    a.isEmpty();
    a.size();
   
    }
    
    }