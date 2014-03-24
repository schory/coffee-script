<<<<<<< HEAD
#CodeMonkey's code:
{Code, Value} = require './nodes'
monkeyFunctions = ['turn','step']

monkify = (expressions) ->
  newExpressions = []
  c = 0
  for exp in expressions
    newExpressions.push exp
    if exp.toString().substr(1,4) == "Call" and monkeyFunctions.indexOf(exp.variable.base.value) > -1
      postFunction = new Code
      postFunction.body.expressions = monkify(expressions.slice(c + 1))
      exp.args.push(postFunction)
      break
    else
      if exp.body
        exp.body.expressions = monkify exp.body.expressions
      if exp.elseBody
        exp.elseBody.expressions = monkify exp.elseBody.expressions
    c = c + 1 
  newExpressions

#marking containsMF:
markMF = (expressions) ->
  for exp in expressions
    exp.isMF = exp.toString().substr(1,4) == "Call" and monkeyFunctions.indexOf(exp.variable.base.value) > -1
    if exp.body
      markMF(exp.body.expressions)

# markMF fragments.expressions

#finding blocks containing MF
markContainsMF = (exp) ->
  if exp.isMF
    exp.containsMF = false
    return true
  if not exp.body
    exp.containsMF = false
    return false
  else
    con = false
    for iterEx in exp.body.expressions
      if markContainsMF iterEx
        con = true
    exp.containsMF = con
    return con

# monkyfyLoop = (loop) ->


#i.e. for i in [1..20]
#       <block>
monkyfyForBlock = (fore) ->
  eef = new If()
  #this will be "if i <= 20"
  eef.condition.first = new Value
  eef.condition.first.base = fore.name
  #that was i
  eef.condition.operator = "<="
  eef.condition.second = fore.source.base.to
  #that was "i <= 20"
  eef.body = fore.body
  return eef  

# for exp in fragments.expressions
  # markContainsMF(exp)

#fragments.expressions = monkyfy(fragments.expressions);
for exp in fragments.expressions
  console.log 1

#End of CodeMonkey's code
=======
# some monkey comment
monkey=123
>>>>>>> bf774f02f18df40443d8b78613461da6f8d7c616
