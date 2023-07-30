# 使用 rust:1.59 镜像
FROM rust:1.59 as builder

# 设置工作目录
WORKDIR /build

# 拷贝当前项目到容器
COPY . .

# 构建release版本  
RUN cargo build --release

# 将生成的so文件复制到指定位置
RUN cp target/release/libmyapp.so /build/libmyapp.so

# 构建一个新镜像,只包含so文件
FROM scratch

COPY --from=builder /build/libmyapp.so /libmyapp.so

# 输出文件到宿主机当前目录
CMD ["cp", "/libmyapp.so", "."]