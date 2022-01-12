class NodeData {
  String name,type;
  bool isAdmin;
  NodeData({this.name,this.type,this.isAdmin});

}

class Node {
  List<NodeData> nodeList=[
NodeData(name:"Test",isAdmin: false,type:"Admin"),
NodeData(name:"Tester",isAdmin:true,type:"Pleb"),

];
}
