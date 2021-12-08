resource app 'radius.dev/Application@v1alpha3' = {
  name: 'webapp'

  
  //CONTAINER
  resource todoRoute 'HttpRoute' = {
    name: 'todo-route'
    properties: {
      gateway: {
        hostname: '*'
      }
    }
  }

  resource todoapplication 'ContainerComponent' = {
    name: 'todoapp'
    properties: {
      container: {
        image: 'radius.azurecr.io/webapptutorial-todoapp'
        //PORTS
        ports: {
          web: {
            containerPort: 3000
            provides: todoRoute.id
          }
        }
        //PORTS
      }
      connections: {
        itemstore: {
          kind: 'mongo.com/MongoDB'
          source: db.id
        }
      }
    }
  }
  //CONTAINER

  //MONGO
  resource db 'mongodb.com.MongoDBComponent' = {
    name: 'db'
    properties: {
      managed: true
    }
  }
  //MONGO
}
