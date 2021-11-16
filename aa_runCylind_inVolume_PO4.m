clear all;close all;


a = readtable('aa_fep_pore.csv');

x = round(a.Var1');
y = round(a.Var2');
z = round(a.Var3');
cor= [x',y',z'];


gx      = min(x):1:max(x);
gy      = min(y):1:max(y);
gz      = min(z):1:max(z);
vol = zeros(length(gx),length(gy),length(gz));


%aa_fep_pore.cvs the Valine COM coordinates
p1 = [-7.84, -5.43, -11.5];% resid 501 = V2476
p2 = [-3.45, 3.77, -10.2]; % resid 1072 = V2476
p3 = [3.34, -5.20, -8.83]; % resid 1643 = V2476

p =CircleCenter(p1,p2,p3);
r=norm(p1 - p);
rmin=2.5;rmax=10.8;
dz=(rmax-rmin)/length(gz);

for i = 1: length(gx)
    for j = 1: length(gy)
        for s = 1: length(gz)
            rs=rmin+(s-1)*dz;
            ri=sqrt((i+min(x)-1-p(1))^2+(j+min(y)-1-p(2))^2);
            if ri <= rs
                vol(i:i+1, j+1, s+1) = 1;
            end
        end
    end
end

for i = 1: length(gx)
    for j = 1: length(gy)
        for s = 1: length(gz)
            rs=rmin+(s-1)*dz;
            ri=sqrt((i+min(x)-1-p(1))^2+(j+min(y)-1-p(2))^2);
            if ri <= rs
                vol(i+1, j:j+1, s+1) = 1;
            end
        end
    end
end
vol(:,:,60)=0;

fv = isosurface(vol, 0.19); % Create the patch object
fv.faces = fliplr(fv.faces); % Ensure normals point OUT


datapath = 'C:\Users\bigting84\Desktop\Lab_groupMeeting\2021\matlab_analysis\FEP_namd\la0\po4_dir';
list = dir(fullfile(datapath, 'po4*.csv'));
numData=[];
Lmin=p(3)-min(z); % 
Lmax=p(3)-min(z)+9; % Lmin-Lmax is defined as chockpoint region
for loop = 1:length(list)
    loop
    aa = readtable(fullfile(datapath, list(loop).name));
    bb = table2array(aa);
    cc = rmmissing(bb);
    pts(:,1) =cc(:,1)-min(x);
    pts(:,2) =cc(:,2)-min(y);
    pts(:,3) =cc(:,3)-min(z);
    pts1 =pts(pts(:,3)<Lmin,:);
    pts2 =pts((pts(:,3)<Lmax & pts(:,3)>Lmin),:);
    pts3 =pts(pts(:,3)>Lmax,:);
    in1 = inpolyhedron(fv, pts1); % Test which are inside the patch
    in2 = inpolyhedron(fv, pts2); % Test which are inside the patch
    in3 = inpolyhedron(fv, pts3); % Test which are inside the patch
    tmp =[sum(in3),sum(in2),sum(in1)];
    numData=[numData,tmp'];
    pt1=pts;
    pts =[];
end

dlmwrite('la0_PO4_numPore.txt',numData)
in = inpolyhedron(fv, pt1);
figure, hold on, view(3) % Display the result
patch(fv,'FaceColor','g','FaceAlpha',0.2)
plot3(pt1(in,1),pt1(in,2),pt1(in,3),'bo','MarkerFaceColor','b')
scatter3(x-min(x),y-min(y),z-min(z),20)
plot3(pt1(~in,1),pt1(~in,2),pt1(~in,3),'ro'), axis image

