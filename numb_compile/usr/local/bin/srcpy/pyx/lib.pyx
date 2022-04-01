def spl(data, sep ,index):
    spdata = list()
    try:
        for pdata in data.split(sep):
            spdata.append(pdata)
        return(spdata[index])
    except IndexError:
        print("\n\t\tYaddaşda hesab yoxdur!\n")
