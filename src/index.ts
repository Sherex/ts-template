interface HelloWorldResponse {
  message: string
}

function helloWorld (): HelloWorldResponse {
  return {
    message: 'Hello World'
  }
}

const hello = helloWorld()
console.log(hello.message)
