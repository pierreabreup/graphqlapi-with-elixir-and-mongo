Mongo.command!(:mongo, [createIndexes: "creative_works",
      indexes: [ %{ key: %{ "identifier.propertyID": 1, "identifier.value": 1},
                    name: "identifier_unique_idx",
                    unique: true} ] ], pool: DBConnection.Poolboy)

    Mix.shell.info("\nSET identifier FIELD AS UNIQUE !\n")
