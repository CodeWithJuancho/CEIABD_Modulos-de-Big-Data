# MongoDB Schema

Podemos crear nuestra collection con el schema por defecto con el validador de `$jsonSchema`

```javascript
db.createCollection("students", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         title: "Student Object Validation",
         required: [ "address", "birth", "name", "scholarYear", "subjects" ],
         properties: {
            name: {
               bsonType: "string",
               description: "'name' must be a string and is required"
            },
            schoolarYear: {
               bsonType: "int",
               minimum: 2017,
               maximum: 3017,
               description: "'year' must be an integer in [ 2017, 3017 ] and is required"
            },
            subjects: {
               bsonType: "object",
               title: "Subjects of the student Object Validation",
               required: ["grade", "name", "teacherName"],
               properties: {
                  grade: {
                  bsonType: [ "double" ],
                  description: "grade must be a double if the field exists"
                  }
               }
            }
         }
      }
   }
})
```

## ¿Cómo valido que el esquema se haya creado?

```javascript
db.getCollectionInfos( { name: "students" })
```

**- Devuelve el objeto validado entero (array)**

**Pero yo solo quiero las validaciones**

```javascript
db.getCollectionInfos( { name: "students" } )[0].options.validator
```

## Vamos a ir practicando con la inserción de elementos

```javascript
db.students.insertOne({test: "foo"})
```

**- ERROR**

```javascript
db.students.insertOne({ address: "foo", name: "foo", birth: "foo", scholarYear:"foo" })
```

**- ERROR**

```javascript
db.students.insertOne({
  address: "foo",
  name: "foo",
  birth: "foo",
  scholarYear:"foo",
  subjects: "foo"
})
```

**- ERROR**

```javascript
db.students.insertOne({
  address: "foo",
  name: "foo",
  birth: "foo",
  scholarYear:"foo",
  subjects: {}
})
```

**- ERROR**

```javascript
db.students.insertOne({
  address: "foo",
  name: "foo",
  birth: "foo",
  scholarYear:"foo",
  subjects: {grade: 10.0, name: "MIA", teacherName: "JJ"}
})
```

**- ERROR**

```javascript
db.students.insertOne({
  address: "foo",
  name: "foo",
  birth: "foo",
  scholarYear:"foo",
  subjects: {grade: "10.0", name: "MIA", teacherName: "JJ"}
})
```

**- ERROR**

```javascript
db.students.insertOne({
  address: "foo",
  name: "foo",
  birth: "foo",
  scholarYear:"foo",
  subjects: {grade: Dobule(10.0), name: "MIA", teacherName: "JJ"}
})
```

**- SUCCESS!!**

### ¿Y si le meto cualquier cosa a parte de la validación funcionará?

```javascript
db.students.insertOne({
  address: "foo",
  name: "foo",
  birth: "foo",
  scholarYear:"foo",
  subjects: {grade: Double(10.0), name: "MIA", teacherName: "JJ"},
  other: "test"
})
```

## Crear el schema para una colección existente que no tiene schema.

You can apply a JSON schema to an existing collection using the collMod command to add a new JSON schema to the collection - @see <https://docs.mongodb.com/manual/core/schema-validation/>

```javascript
db.runCommand( {
   collMod: "contacts",
   validator: { $jsonSchema: {
      bsonType: "object",
      required: [ "phone", "name" ],
      properties: {
         phone: {
            bsonType: "string",
            description: "must be a string and is required"
         },
         name: {
            bsonType: "string",
            description: "must be a string and is required"
         }
      }
   } },
   validationLevel: "moderate"
})
```

## También podemos referenciar el schema en una constante y luego crearlo de la misma manera

```javascript
const studentSchema: {
         bsonType: "object",
         title: "Student Object Validation",
         required: [ "address", "birth", "name", "scholarYear", "subjects" ],
         properties: {
            name: {
               bsonType: "string",
               description: "'name' must be a string and is required"
            },
            schoolarYear: {
               bsonType: "int",
               minimum: 2017,
               maximum: 3017,
               description: "'year' must be an integer in [ 2017, 3017 ] and is required"
            },
            subjects: {
               bsonType: "object",
               title: "Subjects of the student Object Validation",
               required: ["grade", "name", "teacherName"],
               properties: {
                  grade: {
                  bsonType: [ "double" ],
                  description: "grade must be a double if the field exists"
                  }
               }
            }
         }
```

```javascript
const validadorEstudiante = {
  $jsonSchema: studentSchema
}
```

```javascript
db.createCollection("students_const", {
  validator: validadorEstudiante
})
```

### Y lo mismo para una colección existente

```javascript
db.runCommand({
    collMod: "students_const",
    validator: validadorEstudiante,
    validationLevel: "strict",
    validationAction: "error"
   })
```
