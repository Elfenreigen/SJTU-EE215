function c = costofallsample(Matrix)

 table = dlmread('dataform_train.csv');
 Content= table(1,:);
 Number = table(2:2:1000,:);
 equal1 = find(Matrix);
 Numberchosen = Number(:, equal1);
 Contentchosen = Content(:, equal1);
 residual = zeros(500,90);
 costsingle = zeros(500,90);
 n = 1;
 
for j = 1:90
    if ( Matrix(1,j) == 1)
        n = n + 1;
    end
end 

for i = 1:500
    residual(i,:) = abs(Content-interp1(Numberchosen(i,:),Contentchosen,Number(i,:),'spline')); 
end

for i = 1:500
    for j = 1:90
       if (residual(i,j) <= 0.5)
          costsingle(i,j) = 0;
       end
       if (residual(i,j) > 0.5 && residual(i,j) <= 1.0)
          costsingle(i,j) = 1;
       end
       if (residual(i,j) >1.0 && residual(i,j) <= 1.5)
          costsingle(i,j) = 6;
       end
       if (residual(i,j) >1.5 && residual(i,j) <=2.0)
          costsingle(i,j) = 20;
       end
       if (residual(i,j) >2.0)
          costsingle(i,j) = 10000;
       end
    end
end

c = sum(costsingle(:))/500 + 50 * n;
return;

end