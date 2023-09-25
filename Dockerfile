FROM debian
ENV NONINTERACTIVE=true
WORKDIR /app
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y build-essential procps curl file git nano wget unzip awscli
RUN curl -fsSLo /root/install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
RUN chmod 777 /root/install.sh
RUN /root/install.sh
RUN rm -f /root/install.sh
RUN (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /root/.profile
RUN eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; brew tap leoafarias/fvm; brew install fvm
RUN echo; echo 'PATH=$PATH:/home/linuxbrew/.linuxbrew/bin/' >> /etc/profile
RUN echo Y | /home/linuxbrew/.linuxbrew/bin/fvm global stable
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod 777 /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]