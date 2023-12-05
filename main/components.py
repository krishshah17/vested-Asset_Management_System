def create_square_row(text1, text2, text3, value1, value2, value3):
    return f'''
        <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
            <div style="width: 180px; height: 150px; border: 4px solid black; padding: 10px; box-sizing: border-box; color: black; border-radius: 10px; font-weight:bold; background-color:white;">{text1}<br><span style="font-size: 30px;">{value1}</span></div>
            <div style="width: 180px; height: 150px; border: 4px solid black; padding: 10px; box-sizing: border-box; color: black; border-radius: 10px; font-weight:bold; background-color:white;">{text2}<br><span style="font-size: 30px;">{value2}</span></div>
            <div style="width: 180px; height: 150px; border: 4px solid black; padding: 10px; box-sizing: border-box; color: black; border-radius: 10px; font-weight:bold; background-color:white;">{text3}<br><span style="font-size: 30px;">{value3}</span></div>
        </div>
    '''












