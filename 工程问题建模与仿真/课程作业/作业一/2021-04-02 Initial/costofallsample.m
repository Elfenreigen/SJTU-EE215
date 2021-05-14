function c = costofallsample(a)
data =dlmread('dataform_train.csv');
dataVol = data(2:2:1000,:);
dataTem = data(1,:);
Q = 50;
tmp = find(a);
testVol = dataVol(:,tmp);
testTem = dataTem(:,tmp);
error = zeros(500,90);

for i = 1:500
    error(i,:)=abs(dataTem - interp1(testVol(i,:),testTem,dataVol(i,:),'pchip'));
end
err0 = (error <= 0.5);
err1 = (error <= 1.0);
err6 = (error <= 1.5);
err20 = (error <= 2.0);
sumErr = (err1 - err0) + 6 * (err6 - err1) + 20 * (err20 - err6) + 10000 *(ones(500, 90) - err20);
c = sum(sumErr(:)) / 500 + Q * length(testTem);
end
