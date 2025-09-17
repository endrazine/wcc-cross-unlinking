/**
* math_test.c : v0.1 : Tue Sep 16 22:47:27 CEST 2025
* Jonathan Brossard // endrazine@gmail.com
*/


static int not_exported(void)
{
	return 0;
}

__declspec(dllexport) int add_numbers(int a, int b) {
    return a + b;
}

__declspec(dllexport) int multiply(int x, int y) {
    return x * y;
}

__declspec(dllexport) unsigned int fibonacci(unsigned int n) {
    if (n <= 1) return n;
    unsigned int a = 0, b = 1, temp;
    for (unsigned int i = 2; i <= n; i++) {
        temp = a + b;
        a = b;
        b = temp;
    }
    return b;
}

