# University of Washington, Programming Languages, Homework 7, 
# hw7testsprovided.rb

require "./hw7.rb"

# Will not work completely until you implement all the classes and their methods

# Will print only if code has errors; prints nothing if all tests pass

# These tests do NOT cover all the various cases, especially for intersection

#Constants for testing
ZERO = 0.0
ONE = 1.0
TWO = 2.0
THREE = 3.0
FOUR = 4.0
FIVE = 5.0
SIX = 6.0
SEVEN = 7.0
EIGHT = 8.0
NINE = 9.0
TEN = 10.0

#Point Tests
a = Point.new(THREE,FIVE)
if not (a.x == THREE and a.y == FIVE)
	puts "Point is not initialized properly"
end
if not (a.eval_prog([]) == a)
	puts "Point eval_prog should return self"
end
if not (a.preprocess_prog == a)
	puts "Point preprocess_prog should return self"
end
a1 = a.shift(THREE,FIVE)
if not (a1.x == SIX and a1.y == TEN)
	puts "Point shift not working properly"
end
a2 = a.intersect(Point.new(THREE,FIVE))
if not (a2.x == THREE and a2.y == FIVE)
	puts "Point intersect not working properly"
end 
a3 = a.intersect(Point.new(FOUR,FIVE))
if not (a3.is_a? NoPoints)
	puts "Point intersect not working properly"
end
a4 = a.intersect(Line.new(FIVE/THREE, ZERO))
if not (a4.x == THREE and a4.y == FIVE)
	puts "Point intersect with line wrong"
end
a5 = a.intersect(Line.new(THREE, FIVE))
if not (a5.is_a? NoPoints)
	puts "Point intersect with line wrong"
end
a6 = a.intersect(VerticalLine.new(THREE))
if not (a6.x == THREE and a6.y == FIVE)
	puts "Point intersect vline wrong"
end
a7 = a.intersect(VerticalLine.new(TWO))
if not (a7.is_a? NoPoints)
	puts "Point intersect vline wrong"
end
a8 = a.intersect(LineSegment.new(ZERO, ZERO, SIX, TEN))
if not (a8.x == THREE and a8.y == FIVE)
	puts "Point intersect seg wrong"
end
a9 = a.intersect(LineSegment.new(ZERO, ZERO, TEN, THREE))
if not (a9.is_a? NoPoints)
	puts "Point intersect seg wrong"
end

#Line Tests
b = Line.new(THREE,FIVE)
if not (b.m == THREE and b.b == FIVE)
	puts "Line not initialized properly"
end
if not (b.eval_prog([]) == b)
	puts "Line eval_prog should return self"
end
if not (b.preprocess_prog == b)
	puts "Line preprocess_prog should return self"
end

b1 = b.shift(THREE,FIVE) 
if not (b1.m == THREE and b1.b == ONE)
	puts "Line shift not working properly"
end

b2 = b.intersect(Line.new(THREE,FIVE))
if not (((b2.is_a? Line)) and b2.m == THREE and b2.b == FIVE)
	puts "Line intersect not working properly"
end
b3 = b.intersect(Line.new(THREE,FOUR))
if not ((b3.is_a? NoPoints))
	puts "Line intersect not working properly"
end
b4 = b.intersect(Point.new(ONE, EIGHT))
if not (b4.x == ONE and b4.y == EIGHT)
	puts "Line intersect not working properly"
end
b5 = b.intersect(Point.new(TWO, EIGHT))
if not (b5.is_a? NoPoints)
	puts "Line intersect not working properly"
end
b6 = b.intersect(VerticalLine.new(TWO))
if not (b6.x == TWO and b6.y == 11.0)
	puts "Line intersect not working properly"
end
b6 = b.intersect(LineSegment.new(ZERO, ZERO, ONE, ONE))
if not (b6.is_a? NoPoints)
	puts "Line intersect not working properly"
end
b6 = b.intersect(LineSegment.new(ZERO, ZERO, ONE, TEN))
if not (b6.is_a? Point)
	puts "Line intersect not working properly"
	puts b6.x
	puts b6.y
end
b6 = b.intersect(LineSegment.new(ZERO, FIVE, ONE, EIGHT))
if not (b6.x1 == ZERO and b6.y1 == FIVE and b6.x2 == ONE and b6.y2 == EIGHT)
	puts "Line intersect not working properly"
	puts b6.x1
	puts b6.y1
	puts b6.y1
	puts b6.y2
end

#VerticalLine Tests
c = VerticalLine.new(THREE)
if not (c.x == THREE)
	puts "VerticalLine not initialized properly"
end

if not (c.eval_prog([]) == c)
	puts "VerticalLine eval_prog should return self"
end
if not (c.preprocess_prog == c)
	puts "VerticalLine preprocess_prog should return self"
end
c1 = c.shift(THREE,FIVE)
if not (c1.x == SIX)
	puts "VerticalLine shift not working properly"
end
c2 = c.intersect(VerticalLine.new(THREE))
if not ((c2.is_a? VerticalLine) and c2.x == THREE )
	puts "VerticalLine intersect not working properly"
end
c3 = c.intersect(VerticalLine.new(FOUR))
if not ((c3.is_a? NoPoints))
	puts "VerticalLine intersect not working properly"
end
c3 = c.intersect(Line.new(ONE, ZERO))
if not (c3.x == THREE and c3.y == THREE)
	puts "VerticalLine intersect not working properly"
end
c3 = c.intersect(Point.new(ZERO, ZERO))
if not (c3.is_a? NoPoints)
	puts "VerticalLine intersect not working properly"
end
c3 = c.intersect(Point.new(THREE, ZERO))
if not (c3.x == THREE and c3.y == ZERO)
	puts "VerticalLine intersect not working properly"
end

c3 = c.intersect(LineSegment.new(ZERO, ZERO, FOUR, ZERO))
if not (c3.x == THREE and c3.y == ZERO)
	puts "VerticalLine intersect not working properly"
end
c3 = c.intersect(LineSegment.new(THREE, ZERO, THREE, FOUR))
if not (c3.x1 == THREE and c3.y1 == ZERO and c3.x2 == THREE and c3.y2 == FOUR)
	puts "VerticalLine intersect not working properly"
end

#LineSegment Tests
d = LineSegment.new(ONE,TWO,-THREE,-FOUR)
if not (d.eval_prog([]) == d)
	puts "LineSegment eval_prog should return self"
end
d1 = LineSegment.new(ONE,TWO,ONE,TWO)
d2 = d1.preprocess_prog
if not ((d2.is_a? Point)and d2.x == ONE and d2.y == TWO) 
	puts "LineSegment preprocess_prog should convert to a Point"
	puts "if ends of segment are real_close"
end

d = d.preprocess_prog
if not (d.x1 == -THREE and d.y1 == -FOUR and d.x2 == ONE and d.y2 == TWO)
	puts "LineSegment preprocess_prog should make x1 and y1"
	puts "on the left of x2 and y2"
end

dt = LineSegment.new(ZERO, TWO, ZERO, ONE)
dt = dt.preprocess_prog
if not (dt.x1 == ZERO and dt.y1 == ONE and dt.x2 == ZERO and dt.y2 == TWO)
	puts "LineSegment preprocess_prog should make y1 below y2"
end

d3 = d.shift(THREE,FIVE)
if not (d3.x1 == ZERO and d3.y1 == ONE and d3.x2 == FOUR and d3.y2 == SEVEN)
	puts "LineSegment shift not working properly"
end

d4 = d.intersect(LineSegment.new(-THREE,-FOUR,ONE,TWO))
if not (((d4.is_a? LineSegment)) and d4.x1 == -THREE and d4.y1 == -FOUR and d4.x2 == ONE and d4.y2 == TWO)	
	puts "LineSegment intersect not working properly"
end
d5 = d.intersect(LineSegment.new(TWO,THREE,FOUR,FIVE))
if not ((d5.is_a? NoPoints))
	puts "LineSegment intersect not working properly"
end

dt1 = LineSegment.new(ONE, ONE, THREE, THREE)
dt2 = LineSegment.new(ZERO, ZERO, TWO, TWO)
d = dt1.intersect(dt2)
if not (d.x1 == ONE and d.y1 == ONE and d.x2 == TWO and d.x2 == TWO)
	puts "wrong"
end

d = dt2.intersect(LineSegment.new(ONE, ONE, FOUR, FOUR))
if not (d.x1 == ONE and d.y1 == ONE and d.x2 == TWO and d.x2 == TWO)
	puts "wrong"
end

#Intersect Tests
i = Intersect.new(LineSegment.new(-ONE,-TWO,THREE,FOUR), LineSegment.new(THREE,FOUR,-ONE,-TWO))
i1 = i.preprocess_prog.eval_prog([])
if not (i1.x1 == -ONE and i1.y1 == -TWO and i1.x2 == THREE and i1.y2 == FOUR)
	puts "Intersect eval_prog should return the intersect between e1 and e2"
end

#Var Tests
v = Var.new("a")
v1 = v.eval_prog([["a", Point.new(THREE,FIVE)]])
if not ((v1.is_a? Point) and v1.x == THREE and v1.y == FIVE)
	puts "Var eval_prog is not working properly"
end 
if not (v.preprocess_prog == v)
	puts "Var preprocess_prog should return self"
end

#Let Tests
l = Let.new("a", LineSegment.new(-ONE,-TWO,THREE,FOUR),
             Intersect.new(Var.new("a"),LineSegment.new(THREE,FOUR,-ONE,-TWO)))
l1 = l.preprocess_prog.eval_prog([])
if not (l1.x1 == -ONE and l1.y1 == -TWO and l1.x2 == THREE and l1.y2 == FOUR)
	puts "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
end

#Let Variable Shadowing Test
l2 = Let.new("a", LineSegment.new(-ONE, -TWO, THREE, FOUR),
              Let.new("b", LineSegment.new(THREE,FOUR,-ONE,-TWO), Intersect.new(Var.new("a"),Var.new("b"))))
l2 = l2.preprocess_prog.eval_prog([["a",Point.new(0,0)]])
if not (l2.x1 == -ONE and l2.y1 == -TWO and l2.x2 == THREE and l2.y2 == FOUR)
	puts "Let eval_prog should evaluate e2 after adding [s, e1] to the environment"
end


#Shift Tests
s = Shift.new(THREE,FIVE,LineSegment.new(-ONE,-TWO,THREE,FOUR))
s1 = s.preprocess_prog.eval_prog([])
if not (s1.x1 == TWO and s1.y1 == THREE and s1.x2 == SIX and s1.y2 == 9)
	puts "Shift should shift e by dx and dy"
end


t = Intersect.new(Point.new(2.5,1.5),Intersect.new(LineSegment.new(2.0,1.0,3.0,2.0),Intersect.new(LineSegment.new(0.0,0.0,2.5,1.5),Line.new(1.0,-1.0))))
t = t.preprocess_prog.eval_prog([])
puts (t.is_a? Point and t.x == 2.5 and t.y == 1.5)

t = Point.new(1.0,1.0).intersect(LineSegment.new(1.0,1.0,5.0,6.0))
puts (t.x == ONE and t.y == ONE)

t = Point.new(5.0,7.0).intersect(LineSegment.new(-1.0,2.0,5.0,7.0))
puts (t.x == FIVE and t.y == SEVEN)

t = Point.new(1.0,1.0).intersectLineSegment(LineSegment.new(1.0,1.0,5.0,6.0))
puts (t.x == ONE and t.y == ONE)

t = Point.new(5.0,7.0).intersectLineSegment(LineSegment.new(-1.0,2.0,5.0,7.0))
puts (t.x == FIVE and t.y == SEVEN)

t = LineSegment.new(1.0,1.0,5.0,6.0).intersect(Point.new(1.0,1.0))
puts (t.x == ONE and t.y == ONE)

t = LineSegment.new(-1.0,2.0,5.0,7.0).intersect(Point.new(5.0,7.0))
puts (t.x == FIVE and t.y == SEVEN)

t = LineSegment.new(1.0,1.0,5.0,6.0).intersectPoint(Point.new(1.0,1.0))
puts (t.x == ONE and t.y == ONE)

t = LineSegment.new(-1.0,2.0,5.0,7.0).intersectPoint(Point.new(5.0,7.0))
puts (t.x == FIVE and t.y == SEVEN)

t = Line.new(5.0,0.0).intersect(LineSegment.new(1.0,5.0,2.0,2.0))
puts (t.x == ONE and t.y == FIVE)

t = Line.new(5.0,0.0).intersect(LineSegment.new(-1.0,-1.0,1.0,5.0))
puts (t.x == ONE and t.y == FIVE)

t = Line.new(5.0,0.0).intersect(LineSegment.new(-1.0,-1.0,1.0,5.0))
puts (t.x == ONE and t.y == FIVE)

t = Line.new(5.0,0.0).intersectLineSegment(LineSegment.new(1.0,5.0,2.0,2.0))
puts (t.x == ONE and t.y == FIVE)

t = Line.new(5.0,0.0).intersectLineSegment(LineSegment.new(-1.0,-1.0,1.0,5.0))
puts (t.x == ONE and t.y == FIVE)

t = Line.new(5.0,0.0).intersectLineSegment(LineSegment.new(-1.0,-1.0,1.0,5.0))
puts (t.x == ONE and t.y == FIVE)

t = LineSegment.new(1.0,5.0,2.0,2.0).intersect(Line.new(5.0,0.0))
puts (t.x == ONE and t.y == FIVE)

t = LineSegment.new(-1.0,-1.0,1.0,5.0).intersect(Line.new(5.0,0.0))
puts (t.x == ONE and t.y == FIVE)

t = LineSegment.new(-1.0,-1.0,1.0,5.0).intersect(Line.new(5.0,0.0))
puts (t.x == ONE and t.y == FIVE)

t = LineSegment.new(1.0,5.0,2.0,2.0).intersectLine(Line.new(5.0,0.0))
puts (t.x == ONE and t.y == FIVE)

t = LineSegment.new(-1.0,-1.0,1.0,5.0).intersectLine(Line.new(5.0,0.0))
puts (t.x == ONE and t.y == FIVE)

t = LineSegment.new(-1.0,-1.0,1.0,5.0).intersectLine(Line.new(5.0,0.0))
puts (t.x == ONE and t.y == FIVE)

t = VerticalLine.new(3.0).intersect(LineSegment.new(-1.0,-1.0,3.0,3.0))
puts (t.x == THREE and t.y == THREE)

t = VerticalLine.new(-1.0).intersect(LineSegment.new(-1.0,-1.0,3.0,3.0))
puts (t.x == -1.0 and t.y == -1.0)

t = VerticalLine.new(3.0).intersectLineSegment(LineSegment.new(-1.0,-1.0,3.0,3.0))
puts (t.x == THREE and t.y == THREE)

t=VerticalLine.new(-1.0).intersectLineSegment(LineSegment.new(-1.0,-1.0,3.0,3.0))
puts (t.x == -1.0 and t.y == -1.0)

t=LineSegment.new(-1.0,-1.0,3.0,3.0).intersect(VerticalLine.new(3.0))
puts (t.x == THREE and t.y == THREE)

t=LineSegment.new(-1.0,-1.0,3.0,3.0).intersect(VerticalLine.new(-1.0))
puts (t.x == -1.0 and t.y == -1.0)

t=LineSegment.new(-1.0,-1.0,3.0,3.0).intersectVerticalLine(VerticalLine.new(3.0))
puts (t.x == THREE and t.y == THREE)

t=LineSegment.new(-1.0,-1.0,3.0,3.0).intersectVerticalLine(VerticalLine.new(-1.0))
puts (t.x == -1.0 and t.y == -1.0)

t=LineSegment.new(5.0,7.0,9.0,9.0).intersect(LineSegment.new(5.0,7.0,6.0,-1.0))
puts (t.x == FIVE and t.y == SEVEN)

t=LineSegment.new(5.0,2.0,9.0,9.0).intersect(LineSegment.new(-2.0,-1.0,5.0,2.0))
puts (t.x == FIVE and t.y == TWO)

t=LineSegment.new(2.0,3.0,8.0,4.0).intersect(LineSegment.new(1.0,1.0,8.0,4.0))
puts (t.x == EIGHT and t.y == FOUR)

t=LineSegment.new(5.0,7.0,9.0,9.0).intersectLineSegment(LineSegment.new(5.0,7.0,6.0,-1.0))
puts (t.x == FIVE and t.y == SEVEN)

t=LineSegment.new(5.0,2.0,9.0,9.0).intersectLineSegment(LineSegment.new(-2.0,-1.0,5.0,2.0))
puts (t.x == FIVE and t.y == TWO)

t=LineSegment.new(2.0,3.0,8.0,4.0).intersectLineSegment(LineSegment.new(1.0,1.0,8.0,4.0))
puts (t.x == EIGHT and t.y == FOUR)
