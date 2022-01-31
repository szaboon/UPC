function z=f(x,N)
    X=reshape(x,3,N);
    z=0;
    for(i=1:(N-1))
        for(j=(i+1):N)
        z=z+1/norm(X(:,i)- X(:,j));
        end
    end
end
