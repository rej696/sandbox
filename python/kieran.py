# count = 0;
# 
# for i in range(0, 50):
#     for j in range(i + 1, 50):
#         for k in range(j + 1, 50):
#             for l in range(k + 1, 50):
#                 # if all unique:
#                 # increment counter
#                 count += 1
def beans(num_holes: int, num_beans: int) -> int:
    def loop(end: int, rec_depth: int, start: int = 0, rec_count: int = 0):
        if rec_count == rec_depth:
            return 1
        rec_count += 1
        count = 0
        for i in range(start, end):
            count += loop(end, rec_depth, i + 1, rec_count)
        return count

    return loop(num_holes, num_beans)


def beans2(num_holes: int, num_beans: int) -> list:
    '''Beanvengence'''
    beans = []
    for b in range(0, 2 ** num_holes):
        #print("{0:b}".format(b))
        count = 0
        # check validity of binary number (contains correct number of 1s)
        bean = b
        for _ in range(num_holes):
            count += (b & 1)
            b = b >> 1

        if count == num_beans:
            beans.append(bean)

    # PrettyPrint bean list
    # print(["{0:b}".format(b) for b in beans])
    return beans

if __name__ == "__main__":
    num_holes = 50
    num_beans = 4
    list_of_beans = beans2(num_holes, num_beans)
    print(["{0:b}".format(b) for b in list_of_beans])
    print(len(list_of_beans))

