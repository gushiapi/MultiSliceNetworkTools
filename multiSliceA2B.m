function [B,twomu,p,T] = multiSliceA2B(A, gplus,gminus,omega,BType)
T=length(A);
p=size(A{1},1);
% if u want more B, added it in the case
switch BType   
    case 'orderedSlice'     
        Bplus=spalloc(p*T,p*T,p*p*T);
        Bminus=spalloc(p*T,p*T,p*p*T);
        twomuplus = 0; twomuminus = 0;     
        for s=1:T
            Aplus = A{s}; Aminus = -A{s};
            Aplus(A{s} < 0) = 0; Aminus(A{s} > 0) = 0;
            kplus=sum(Aplus); kminus = sum(Aminus);
            twomplus=sum(kplus); twomminus = sum(kminus);
            twomuplus = twomuplus + twomplus; twomuminus = twomuminus + twomminus;
            indx=[1:p]+(s-1)*p;
            Bplus(indx,indx)=Aplus-gplus*(kplus'*kplus)/twomplus;
            Bminus(indx,indx) = Aminus-gminus*(kminus'*kminus)/twomminus;
        end
        B = Bplus-Bminus + omega*spdiags(ones(p*T,2),[-p,p],p*T,p*T);
        twomu = twomuplus + twomuminus + 2*omega*p*(T-1);
    case 'randomSliceConnection'
        Bplus=spalloc(p*T,p*T,p*p*T);
        Bminus=spalloc(p*T,p*T,p*p*T);
        Bomega=spalloc(p*T,p*T,2*p*(T-1));
        twomuplus = 0; twomuminus = 0;     
        for s=1:T
            Aplus = A{s}; Aminus = -A{s};
            Aplus(A{s} < 0) = 0; Aminus(A{s} > 0) = 0;
            kplus=sum(Aplus); kminus = sum(Aminus);
            twomplus=sum(kplus); twomminus = sum(kminus);
            twomuplus = twomuplus + twomplus; twomuminus = twomuminus + twomminus;
            indx=[1:p]+(s-1)*p;
            Bplus(indx,indx)=Aplus-gplus*(kplus'*kplus)/twomplus;
            Bminus(indx,indx) = Aminus-gminus*(kminus'*kminus)/twomminus;
        end
        for s = 1:T-1
            indL = [1:p]+(s-1)*p;
            indH = [1:p]+s*p;
            randBlock = omega*eye(p); randBlock = randBlock(:,randperm(p));
            Bomega(indL, indH) = randBlock;
            Bomega(indH, indL) = randBlock';
        end     
        B = Bplus-Bminus + Bomega;
        twomu = twomuplus + twomuminus + 2*omega*p*(T-1);    
        return;
    case 'randomSliceOrder'
        Bplus=spalloc(p*T,p*T,p*p*T);
        Bminus=spalloc(p*T,p*T,p*p*T);
        twomuplus = 0; twomuminus = 0;
        A = A(randperm(numel(A)));
        for s=1:T
            Aplus = A{s}; Aminus = -A{s};
            Aplus(A{s} < 0) = 0; Aminus(A{s} > 0) = 0;
            kplus=sum(Aplus); kminus = sum(Aminus);
            twomplus=sum(kplus); twomminus = sum(kminus);
            twomuplus = twomuplus + twomplus; twomuminus = twomuminus + twomminus;
            indx=[1:p]+(s-1)*p;
            Bplus(indx,indx)=Aplus-gplus*(kplus'*kplus)/twomplus;
            Bminus(indx,indx) = Aminus-gminus*(kminus'*kminus)/twomminus;
        end
        B = Bplus-Bminus + omega*spdiags(ones(p*T,2),[-p,p],p*T,p*T);
        twomu = twomuplus + twomuminus + 2*omega*p*(T-1);  
    otherwise
        error('B Type not supported!');
end