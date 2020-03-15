# What is it?

This project is a Graphlql API made with elixir, phoenix framework and mongodb on docker environment. The following tools are installed: 
* mix 
* hex 
* phx_new

This project is a guide for anyone who tries to use mongodb with phoenix framework. I've created it above docker container because is more easy for me, but if you already have elixir environment in your local machine, feel free to run the project in your machine. Remember yourself, in this situation, you have to setup a mongodb server by on your own.

The data sample was built on LRMI format (http://lrmi.dublincore.org/). I used this format because is pretty simple to explain the project and because I'm using in production at my job.

In this Medium article https://medium.com/@pierreabreu/how-to-create-a-graphql-api-with-elixir-and-mongodb-f3a9e0602832 I explain deeply the project, design code and other things.

# How to use it?

After you've clone this project, follow the steps:
- open a terminal session in your terminal tool (Iterm, Terminal, Putty)
- go to the folder where you've cloned the project (Ex.: ```cd graphqlapi-with-elixir-and-mongo```)
- type the command: ```make run```

This command will run the container and open a session inside the container. If all goes well, you will be in the path ```/usr/src/app```.   In this path, type `cd lrmi` and after that type the following commands:
* ```mix ecto.setup```: This command creates the database and seed with sample data
* ```mix phx.server```

The server will run on `http://localhost:4000`. To test it, you can use https://insomnia.rest/.

At last, test the queries:
````
query {
  creativeWorks(first: 2) {
    edges {
      node {
        name
        identifier {
          propertyId
          value
        }
      }
      cursor
    }
    pageInfo {
      startCursor
      endCursor
      hasNextPage
      hasPreviousPage
    }
  }
}
````

````
query {
  creativeWorks(first: 2, after: "5c8eaac3380b1ac5dee8531e") {
    edges {
      node {
        name
        identifier {
          propertyId
          value
        }
      }
      cursor
    }
    pageInfo {
      startCursor
      endCursor
      hasNextPage
      hasPreviousPage
    }
  }
}
````

```
query {
  creativeWorks(first: 2, identifier: {value: "112121", propertyId: "ContentHost-ContentID"}) {
    edges {
      node {
        name
        identifier {
          propertyId
          value
        }
      }
      cursor
    }
    pageInfo {
      startCursor
      endCursor
      hasNextPage
      hasPreviousPage
    }
  }
}
```

When you have to finish your job, go to the terminal session where you've run `make run` and stop cowboy server pressing CTR+C twice. After that, type `exit` and at last `make down`

##### IMPORTANT!
when you run ```make run``` at the first time, the docker image will be created. In the next times, docker compose will use the same image.

# Automated Testing
To run the test, go to the console when I've run `make run`, go to the LRMI project `cd lrmi` and type `mix test`

I didn't create tests cases for all code, I've just created for more important areas of the project.

# FAQ

=> **I don't want to use this project any more, is there a command to destroy the project?**
**A:** Yes, open your terminal session, go to the project and type de command `make destroy`

=> **I'm having problems to up the container or run phoenixproject project. What can I do ?**
**A:** create a [github issue](https://github.com/pierreabreup/graphqlapi-with-elixir-and-mongo/issues) . I promise will answer as soon as possible
