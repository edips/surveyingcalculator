import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Universal 2.2
import Fluid.Controls 1.0 as FluidControls
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import "../components/common"
TopSheet{
    title: "Using Python as a Calculator"

    SFlickable {
        id:optionsPage
        anchors.top: toolbar.bottom
        contentHeight: Math.max(optionsColumn.implicitHeight, height)+50
Column{
    anchors.horizontalCenter: parent.horizontalCenter
    id:optionsColumn
    spacing: 5
    width: parent.width
    anchors.top:parent.top
    anchors.topMargin    : 15
    anchors.bottomMargin : 5
    anchors.leftMargin :5
    anchors.rightMargin  : 5
    Rectangle{
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        height: helpl.height
        width: helpl.width

        //<br><br><b>angle = length of the arc / radius of the circle</b><br><br>

        Label{
            id:helpl
            font.pixelSize:17
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Label.RichText
            text:qsTr("
PyCalculator is based on <b>Python 2.7</b>. Python is an easy to learn, powerful programming language.
This documentation introduces the reader informally to the basic concepts and features of the Python language for math calculations.
It can be used as a tool for simple or complex mathematical calculations.<br>
<br>
<b>print Function</b><br>
The print() function prints the specified message to the screen. The message can be a string, number or any other object.
In order to print the Hello world string, use the print function as follows:<br>
>> print \"Hello\"<br>
Hello<br>
<br>

<b>Using Python as a Calculator</b><br>
To begin with the simplest mathematical functions, including integral
addition, subtraction, multiplication and division, can be performed in IDLE using
the following mathematical expressions1:<br>
>> print 3+5 # addition<br>
8<br>
>> print 3-2 # subtraction<br>
1<br>
>> print 6*7 # multiplication<br>
42<br>
>> print 8/4 # division<br>
2<br>
<br>
As can be seen from the examples above, a simple Python expression is similar to a
mathematical expression. It consists of some numbers, connected by a mathematical
operator.
Since expressions themselves represent values, they can be used as operands in
longer composite expressions.<br>
>> print 3+2-5+1<br>
1<br>
>> print 3+2*5-4<br>
9<br>
The expression above evaluates to 9, because the multiplication (*) operator has a
higher priority compared with the+and−operators. The order in which operators are
applied is called operator precedence, and mathematical operators in Python follow
the natural precedence by the mathematical function. For example, multiplication
(*) and division (/) have higher priorities than addition (+) and subtraction (−). An
operator that has higher priority than multiplication is the power operator (**).<br>
>> print 5 ** 2 # power<br>
25<br>
In general, a ** b denotes the value of a to the power of b.
Similar to mathematical equations, Python allows the use of brackets (i.e.
‘(’ and ‘)’) to manually specify the order of evaluation. For example,<br>
>> print (3+2)*(5-4) # brackets<br>
5<br>
An operator can also be unary, taking only a single
operand. An example unary operator is −, which takes a single operand and negates
the number.<br>
>> print -(5*1) # negation<br>
-5<br>
Until this point, all the mathematical expressions have been integral, with the
values of literal operands and expressions being integers. Take the division operator
(/) for example,<br>
>> print 5/2 # division with integer operands<br>
2<br>
The result of the integral division operation is the quotient 2, with the fractional
part 1 discarded. To find the remainder of integer division, the modulo operator (%)
can be used.<br>
>> print 5%2 # modulo<br>
1<br>
<b>Floating Point Expressions</b><br>
So for all the expressions in this chapter are integer expressions, of which all the
operands and the value are integers. However, for the expressions 5/2, sometimes
the real number 2.5 is a more appropriate value. In computer science, real number
are typically called floating point number. To perform floating point arithmetics,
at least one floating point number must be put in the expression, which results in a
floating point expression. For example,<br>
>> print 5.0/2 # floating point division<br>
2.5<br>
>> print 5/2.0 # floating point division<br>
2.5<br>
>> print 25 ** 0.5 # floating point power<br>
5.0<br>
The last example above calculates the positive square root of 25. Regardless of
operands, when all the numbers in a Python expression are integers, the expression
is an integer expression, and the value of the expression itself is an integer. However,
when there is at least one floating point number in an expression, the expression is
a floating point expression, and its value is a floating point number. Below are some
more examples, which show that +, − and * operators can all be applied to floating
point numbers, resulting in floating point numbers.<br>
>> print 3.0+5.1 # floating point addition<br>
8.1<br>
>> print 1.0-2.4 # floating point subtraction<br>
-1.4<br>
>> print 5.5*0.3 # floating point multiplication<br>
1.65<br>
The observation above leads to an important fact about Python: things have types.
Literals have types. The literal 3 indicates an integer, and the literal 3.0 indicates a
floating point number. Expressions have types, and their types are the types of their
values. The type of a literal or expression can be examined by using the following
commands:
<br>>> print type(3)
<br>&lt;type ‘int’>
<br>>> print type(3.0)
<br>&lt;type ‘float’>
<br>>> print type(3+5)
<br>&lt;type ‘int’>
<br>>> print type (3+5.0)
<br>&lt;type ‘float’><br>
The command type(x) returns the type of x. This command is a function call in
Python, which type is a built-in function of Python. We call a function with specific
arguments in order to obtain a specific return value. In the case above, calling the
function type with the argument 3 results in the ‘integer type’ return value.
Function calls are also expressions, which are written in a form similar to mathematica function,
 with a function name followed by a comma-separated list of arguments enclosed in a pair of brackets. The value of a function call expression is the
return value of the function. In the above example, type is the name of a function,
which takes a single argument, and returns the type of the input argument. As a result,
the function call type(3.0) evaluates to the ‘float type’ value.<br>
Intuitively the return value of a function call is decided by both the function itself
and the arguments of the call. To illustrate this, consider two more functions. The int
function takes one argument and converts it into an integer, while the float function
takes one argument and converts it into a floating point number.<br>
>> print float(3)<br>
3.0<br>
>> print int(3.0)<br>
3<br>
>> print float(3)/2<br>
1.5<br>
>> print 3*float(3-2*5+4)**2<br>
27.0<br>
As can be seen from the examples above, when the function is type, the return
values are different when the input argument is 3 and when the input argument is
3.0. On the other hand, when the input argument is 3, the return value of the function
type differs from that of the function float. This shows that both the functions and
the arguments determine the return value.<br>
The last two examples above is a composite expression, in which the function call
float(3) is evaluated first, before the resulting value 3.0 is combined with the literal 2
by the operator /. Function calls have higher priorities than mathematical operators
in operator precedence.<br>
The int function converts a floating point number into an integer by discarding all
the digits after the floating point. For example,<br>
>>  printint(3.0)<br>
3<br>
>> print int(3.1)<br>
3<br>
>> print int(3.9)<br>
3<br>
In the last example, the return value of int(3.9) is 3, even though 3.9 is numerically
closer to the integer 4. For floating-point conversion by rounding up an integer, the
round function can be used.<br>
>> print round(3.3)<br>
3<br>
>> print round(3.9)<br>
4<br>
The round function can round up a number not only to the decimal point, but also to
a specific number of digits after the decimal point. In the latter case, two arguments
must be given to the function all, with the second input argument indicating the
number of digits to keep after the decimal point. The following examples illustrate
this use of the round function with more than one input arguments. Take note of the
comma that separates two input arguments.<br>
>> print round(3.333, 1)<br>
3.3<br>
>> print round(3.333, 2)<br>
3.33<br>
A floating point operator that results in an integer value is the integer division
operator (//), which discards any fractional part in the division.<br>
>> print 3.0//2<br>
1<br>
>> print 3.5//2<br>
1<br>
Correspondingly, the modulo operator can also be applied to floating point division.<br>
>> print 3.5%2<br>
1.5<br>
Another useful function is abs, which takes one numerical argument and returns
its absolute value.<br>
>> print abs(1)<br>
1<br>
>> print abs(1.0)<br>
1.0<br>
>> print abs(-5)<br>
5<br>
<b>Identifiers, Variables and Assignment</b><br>
The set of arithmetic expressions introduced above allows simple calculations using
IDLE. For example, suppose that the annual interest rate of a savings account is 4 %.
To calculate the amount of money in the account after three years, with an initial
sum of 3, 000 dollars is put into the account, the following expression can be used.<br>
>> print 3000*1.04**3<br>
3374.592<br>
One side note is that brackets can be used to explicitly mark the intended operator
precedence, even if they are redundant. In the case above, 3000 * 1.04 * *3 can
be written as 3000 * (1.04 * *3) to make the operator precedence more obvious.
In general, being more explicit can often make the code easier to understand and
less likely to contain errors, especially when there are potential ambiguities (e.g.
non-intuitive or infrequently used operator precedence).<br>
For a second example, suppose that the area of a square is 10 m2. The length of
each edge can be calculated by:<br>
>> print 10**0.5<br>
3.1622776601683795<br>
The result can be rounded up to the second decimal place.<br>
>> print round(10**0.5, 2)<br>
3.16<br>
For notational convenience and to make programs easier to maintain, Python
allows names to be given to mathematical values. An equivalent way of calculating
the edge length is:<br>
>> a=10<br>
>> w=a**0.5<br>
>> print round(w, 2)<br>
3.16<br>
In the example above, a denotes the area of the square, and w denotes its width.
The use of a and w makes it easier to understand the underlying physical meanings
of the values. a and w are called identifiers in Python. Each Python identifiers is
bound to a specific value. In the example, a is bound to 10 and w is bound to √10.
Identifiers can be bound to new value:<br>
>> x=1<br>
>> print x<br>
1<br>
>> x=2<br>
>> print x<br>
2<br>
In the example, the value of x is first 1, and then 2. Because identifiers can change
their values, they are also called variables.
For another example problem, suppose that a ball is tossed up on the edge of a
cliff with an initial velocity v0, and that the initial altitude of the ball is 0 m. The
question is to find the vertical position of the ball at a certain number of seconds t
after the toss. If the initial velocity of 5 m/s and the time is 0.1 s, the altitude can be
calculated by:<br>
>> v0=5<br>
>> g=9.81<br>
>> t=0.1<br>
>> h = v0*t-0.5*g*t**2<br>
>> print round(h, 2)<br>
0.45<br>
To further obtain the vertical location of the ball at 1 s, only t and h need to be
modified.<br>
>> t=1<br>
>> h=v0*t-0.5*g*t**2<br>
>> print round(h, 2)<br>
0.09<br>
Note that the value of h must be calculated again after the value of t changes.
This is because an assignment statement binds an identifier to a value, rather than
establishing a mathematical correlation between a set of variables. When h = v0 *
t − 0.5 * g * g * t * * 2 is executed, the right hand side of = is first evaluated
according to the current values of v0, g and t, and then the resulting value is bound
to the identifier h. This is different from a mathematical equation, which establishes
factual relations between values. When the value of t changes, the value of h must
be recalculated using h = v0 * t − 0.5 * g * g * t * * 2. For another example,<br>
>> x=1<br>
>> x=x+1<br>
>> x<br>
2<br>
There are three lines of code in this example. The first is an assignment statement,
binding the value 1 to the identifier x. The second is another assignment statement,
which binds the value of x + 1 to the identifier x. When this line is executed, the
right hand side of = is first evaluated, according to the current value of x. The result
is 2. This value is in turn bound to the identifier x, resulting in the new value 2 for
this identifier. The third line is a single expression, of which the value is displayed
by IDLE. Think how absurd it would be if the second line of code is treated as a
mathematical equation rather than an assignment statement!<br>
An equivalent but perhaps less ‘counter-intuitive’ way of doing x = x + 1 is<br>
x+= 1<br>
>> x=1<br>
>> x+=1<br>
>> print x<br>
2<br>
The same applies to x = x − 3, x = x * 6, and other arithmetic operators.<br>
>> x-=3<br>
>> print x<br>
-1<br>
>> x*=6<br>
>> x<br>
-6<br>
In general, x<op>=y is equivalent to x=x<op>y, where <op> can be +, −, *,
/, % etc. The special assignment statements +=, −=, *=, /= and %= can be used
as a concise alternative to a = assignment statement when it incrementally changes
the value of one variable.<br>
Given the fact above, it is not difficult to understand the outputs, if the following
commands are entered into IDLE to find the position of the ball after 3 s in the
previous problem.<br>
(continued from above)<br>
>> t=3<br>
>> print round(h, 2)<br>
0.09<br>
>> h=v0*t-0.5*g*t**2<br>
>> print round(h, 2)<br>
-29.15<br>
The commands above are executed sequentially and individually. When t is bound
to the new value 3, h is not affected, and remains 0.09. After the new h assignment is
executed, its value changes to −29.15 according to the new t. Cascaded assignments.
Several assignment statements to the same value can be cascaded into a single line.
For example, a = 1 and b = 1 can be cascaded into a = b = 1.<br>
>> a=b=1<br>
>> print a<br>
1<br>
>> print b<br>
1<br>
<b>More Mathematical Functions Using the math module</b><br>
Several mathematical functions have been introduced so far, which include addition, subtraction, multiplication,
 division, modulo and power. There are more mathematical functions that a typical calculator can do, such as factorial, logarithm and
trigonometric functions. These functions are supported by Python through a special
module called math.<br>
A Python module is a set of Python code that typically includes the definition of
specific variables and functions. The next chapter will show that a Python module can
be nothing but a normal Python program. In order to use the variables and functions
defined in a Python module, the module must be imported. For example,<br>
>> from math import *<br>
>> print pi<br>
3.141592653589793<br>
>> print e<br>
2.718281828459045<br>
In the example above, the math module is imported by the statement from math import *.
The import statement is the third type of statement introduced in this chapter, with
the previous two being the assignment statement and the del statement. The import
statement loads the content of a specific module, and adds the name of the module in
the binding table, so that content of the module can be accessed by using the name,
followed by a dot (.).<br>
Two mathematical constants pi and e, are defined in the mathmodule, and accessed
by using ‘math.’ in the above example. Both pi (π) and e are defined as floating point
numbers, up to the precision supported by a computer word.
Mathematical functions can be accessed in the same way as constants, by using
‘math.’. For example, the factorialfunction returns the factorial of the input argument.<br>
>> from math import *<br>
>> print factorial(3)<br>
6<br>
>> print factorial(8)<br>
40320<br>
The math module provides several classes of functions, including power and
logarithmic functions, trigonometric functions and hyperbolic functions. The two
basic power and logarithmic functions are math.pow(x, y) and math.log(x, y), which
take two floating point arguments x, and y, and return x y and logy x, respectively.<br>
>> from math import *<br>
>> pow(2, 5)<br>
32.0<br>
>> pow(25,0.5)<br>
5.0<br>
>> log(1000,10)<br>
2.9999999999999996<br>
Note the rounding off error in the last example. The functions pow and
log always return floating point numbers. The function log can also take
one argument only, in which case it returns the natural logarithm of the input argument.<br>
>> from math import *<br>
>> print log(1)<br>
0.0<br>
>> log(e)<br>
1.0<br>
>> log(10)<br>
2.302585092994046<br>
There is also a handy function to calculate the base-10 logarithm of an input floating point number: math.log10(x). The function take a single floating point argument.
As two other special power functions, exp(x) can be used to calculate the value
of ex , and sqrt(x) can be used to calculate the square root of x.<br>
The set of trigonometric functions that the math module provide include sin
(x), cos(x), tan(x), asin(x), acos(x) and atan(x), which
calculate the sine, the cosine, the tangent, the arc sine, the arc cosine, the arc tangent
of x, respectively.<br>
>> from math import *<br>
>> sin(3)<br>
0.1411200080598672<br>
>> cos(pi)<br>
-1.0<br>
>> tan(3*pi)<br>
-3.6739403974420594e-16<br>
>> asin(1)<br>
1.5707963267948966<br>
>> acos(1)<br>
0.0<br>
>> print atan(100)<br>
1.5607966601082315<br>
Note the rounding off errors in some of the examples above. All angles in the
functions above are represented by radians. The math module provides two functions
to convert between radians and degrees: the math.degrees function takes a single
argument x, and converts x from radians to degrees; the radians function takes
a single argument x, and converts x from degrees to radians.<br>
<br>
<b>Examples</b><br>

Now that we know how to work with numbers, let's write a program.<br>
 Let's say you want to find out how much you weigh in stone. A concise program can make short work of this task.
Since a stone is 14 pounds, and there are about 2.2 pounds in a kilogram, the following formula should do the trick:<br>

>> mass_kg = int(input(\"What is your mass in kilograms?\" ))<br>
>> mass_stone = mass_kg * 2.2 / 14<br>
>> print \"You weigh\", mass_stone, \"stone.\"<br>

mass_stone = mass_kg * 2.2 / 14<br>

Another examlpe, finding distance between two points:<br>

>> from math import *<br>
>> x1 = 456859.84<br>
>> x2 = 456127.95<br>
>> y1 = 512548.69<br>
>> y2 = 512396.77<br>
>> dx = x1 - x2<br>
>> dy = y1 - y2<br>
>> distance = sqrt ( dx*dx + dy*dy )<br>
>> print distance<br>
747.49090864<br>
<br>")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }

        Rectangle{
            anchors.horizontalCenter: parent.horizontalCenter
            height:sin_g2.height
            width:sin_g2.width
            color: "transparent"
            Image {
                id:sin_g2
                width: 320
                fillMode: Image.PreserveAspectFit
                source:"qrc:h-pycalc.jpg"
            }
        }

        Rectangle{
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            height: helpl2.height
            width: helpl2.width

Label{
      id:helpl2
      font.pixelSize:17
      anchors.horizontalCenter: parent.horizontalCenter
      textFormat: Label.RichText
      onLinkActivated: Qt.openUrlExternally(link)
      text:qsTr("
You can use unlimited variables for any calculations using Python. Python is very flexible and easy to use for daily calculations and automations.
You can also install Python for your computer, it is available for Windows, MacOS and Linux. For more information please visit <a href='https://www.python.org'>www.python.org</a><br>
")
            wrapMode: Label.WordWrap
            width: optionsColumn.width-30
            //font.bold: true
        }
    }



}
    }
}
