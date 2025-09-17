__attribute__((visibility("default")))
int add_numbers(int a, int b) {
    return a + b;
}

__attribute__((visibility("default")))
int multiply(int x, int y) {
    return x * y;
}

__attribute__((visibility("default")))
unsigned int fibonacci(unsigned int n) {
    if (n <= 1) return n;
    unsigned int a = 0, b = 1, temp;
    for (unsigned int i = 2; i <= n; i++) {
        temp = a + b;
        a = b;
        b = temp;
    }
    return b;
}

int main()
{
	fibonacci(8);

}
