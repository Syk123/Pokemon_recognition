function val = recognize_digits(I,thrs)
if thrs==0
    I = im2bw(I);

elseif thrs>0.75
    I = im2bw(I,thrs);
else
    I = im2bw(I,thrs);
end

if nnz(I)>numel(I)-nnz(I)
    I = ~I;
end
val = 10;
%imshow(I);


x = load('templates.mat');

num = {imresize(x.zero,[15 12]); imresize(x.one, [15 12]);imresize(x.two,[15 12]); imresize(x.three, [15 12]); imresize(x.four,[15 12]); imresize(x.five,[15 12]); imresize(x.six,[15 12]); imresize(x.seven,[15 12]); imresize(x.eight,[15 12]); imresize(x.nine,[15 12])};

L = bwlabel(I);
number_of_digits = max(L(:));

stats = regionprops(L, 'BoundingBox');

bb = [stats.BoundingBox];
d = 0;
for i=1:number_of_digits
    b = bb((i-1)*4+1:(i-1)*4+4);
    rectangle('Position',b, 'EdgeColor','red');
    digit = I(ceil(b(2)):ceil(b(2))+b(4)-1,ceil(b(1)):ceil(b(1))+b(3)-1);
    digit = imresize(digit,[15 12]);
    %figure(1); imshow(digit);
    for j=1:10
        %figure(2); imshow(num{j});
        count(j) = nnz(xor(digit,num{j}));
    end
    [m,idx] = min(count);
    d = d+(idx-1)*10^(number_of_digits-i);
    val = d;
end


