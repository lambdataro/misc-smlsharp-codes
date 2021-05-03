structure Setup =
struct
  val _ = DBSchema.initDB()
  val _ = DBSetup.setupDB()
end
