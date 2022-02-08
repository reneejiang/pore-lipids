function p = CircleCenter(p1, p2, p3)
 pf= cross(p1-p2, p1-p3);

 %if any(pf == 0)
 %    error('no on the same line');
 %end

 p12 = (p1 + p2)/2;
 p23 = (p2 + p3)/2;

 p12f = cross(pf, p1-p2);
 p23f = cross(pf, p2-p3);

 ds = ( (p12(2)-p23(2))*p12f(1) - (p12(1)-p23(1))*p12f(2) ) / ( p23f(2)*p12f(1) - p12f(2)*p23f(1) );
 p = p23 + p23f .* ds;

end
