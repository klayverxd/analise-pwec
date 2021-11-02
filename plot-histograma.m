%Extrai dados de arquivo
arquivo = fopen('dados_tempo_exec.txt');
v = fscanf(arquivo,'%f');
%%Tempo de execucao medio
tem_exec_ref = mean(v); %us
subplot(4,1,1)

plot(1:length(v),v,1:length(v),tem_exec_ref.*ones(length(v),1))
axis([0 length(v) 0 1.1*max(v)])
%axis([0 length(v) 0 200])
xlabel('Casos de Teste','fontweight','bold','fontsize',16)
ylabel('Tmp. de Exec. [us]','fontweight','bold','fontsize',16)

%Maximo de Blocos (BM)
x=[];
bloco = 5;
for i=0:bloco:(length(v)-bloco),
x=[x max(v(i+1:i+bloco))];
end
xmb=sort(x);

%Histograma
subplot(4,1,2)
[h,x]=hist(xmb,[min(xmb):1:max(xmb)]);
bar(x,h);
colormap lines
axis([0.8*(min(xmb)) 1.1*max(xmb) 0 1.1*max(h)])
xlabel('Tempo de Execucao [us]','fontweight','bold','fontsize',16)
ylabel('Freq.','fontweight','bold','fontsize',16)

% x is the support.
% k is the shape parameter of the GEV distribution. (Also denoted gamma or xi.)
% sigma is the scale parameter of the GEV distribution. The elements of sigma must be positive.
% mu is the location parameter of the GEV distribution.
[pfit, pci] = gevfit (xmb);
ypdf = gevpdf (xmb, pfit(1),pfit(2),pfit(3))
ycdf = gevcdf (xmb, pfit(1),pfit(2),pfit(3))

subplot(4,1,3)
plot(xmb, ypdf, 'linew', 2)
colormap lines
axis([0.8*min(xmb) 1.1*max(xmb) 0 1.1*max(ypdf)])
xlabel('Tmp. de Exec. [us]','fontweight','bold','fontsize',16)
ylabel('PDF','fontweight','bold','fontsize',16)

subplot(4,1,4)
plot(xmb, ycdf, 'linew', 2)
colormap lines
axis([0.8*min(xmb) 1.1*max(xmb) 0 1.1*max(ycdf)])
xlabel('Tmp. de Exec. [us]','fontweight','bold','fontsize',16)
ylabel('CDF','fontweight','bold','fontsize',16)
