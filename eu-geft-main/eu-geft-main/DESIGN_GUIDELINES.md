# Design/Coding guidelines

## General

#### Naming
Try to avoid acronyms in the code/tests.

#### Immutability
Try to default to using immutable data structures (using `val` in Kotlin, rather than `var`. Use `const` in TypeScript).

## Backend

#### Data structure validation
Use ApprovalTests to ensure the structure of your objects (eg: contract objects for integrators) did not inadvertently break.
For more information on ApprovalTests, see: [here](https://approvaltests.com/)

Example:
```kotlin
@UseReporter(IntelliJReporter::class, ClipboardReporter::class)
class ObjectWithString {
    @Test
    fun `defines an object with a string inside`() {
        val text = "Hello World"

        val result = ObjectWithString(value = text)

        Approvals.verify(serializeAsString(result))
    }

    class ObjectWithString(val value: String)
}
```

#### Language usage
Favor Kotlin over Java, transition any code that you're changing from Java to Kotlin.
We're transitioning from Java to Kotlin for all backend/serverside code. This can be done iteratively.
The most value should be gained from starting with the data structures and bringing those into the Kotlin code.

#### Exceptions
When coding for failure, use the `Response<T>` object. This object helps to make explicit an error occurred during an external interaction call (e.g.: a web call).
So in this way the code does not need to be littered with try...catch code. 
The `Response<T>` object structure models [Railroad oriented programming](https://medium.com/@naveenkumarmuguda/railway-oriented-programming-a-powerful-functional-programming-pattern-ab454e467f31).

#### Null-handling
Unless we know the exact business requirements for handling null values, favor sending null to the lender even when it's a required field.

Keep `null` at the edge of the application (eg: check for null input upfront if it makes the code more readable)
Example:
```kotlin
fun funThatReturnsAPotentiallyNullableObject(input1: Any? = null, input2: Any? = null): Any? {
    if (input1 == null || input2 == null) {
        return null // this makes it very easy to reason what happens when there's a null value present.
    }
    //inputs are compile-time null-safe here.
    return doSomethingElseFor(input1, input2)
}
```

### Testing
#### Nullable Infrastructure Wrappers
When unit-testing code, favor using [Nullable Infrastructure Wrappers](https://www.jamesshore.com/v2/blog/2018/testing-without-mocks) over mocking.

#### Assertion
Favor AssertJ over any other assertion frameworks.
eg: 
```kotlin
assertThat(true).isTrue();
```
When you are working on code with a different syntax, feel free to refactor (with care) to using AssertJ instead. We are migrating away from using the AssertJ extension methods. eg:
```kotlin
true.shouldBeTrue() // This can be refactored to using AssertJ.
``` 

## Frontend
`TODO`
`hooks linter??`