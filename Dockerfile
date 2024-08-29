FROM ubuntu:focal
RUN apt update && apt install -y wget 
RUN wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb && dpkg -i libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb
RUN wget https://dot.net/v1/dotnet-install.sh && bash dotnet-install.sh -c 3.1
WORKDIR /app
COPY . .
ENV DOTNET_ROOT=/root/.dotnet
ENV PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
EXPOSE 8000

CMD ["/root/.dotnet/dotnet", "run"]
