 
import { StyleSheet } from 'react-native'
  
const styles = StyleSheet.create({
    container: {
      flex: 1, 
      alignItems: "stretch"
    },
    list: {
      alignItems: "stretch"
    },
    quicklook: {
      alignItems: "center",
      justifyContent: "center",
    },
    text: { 
      textAlign: 'center',
      fontSize: 14,
      marginVertical: 4
    },
    item: {
      justifyContent: "center",
      backgroundColor: '#FFFFFF',
      padding: 5,
      marginVertical: 8,
      marginHorizontal: 16,
    },
    separator: {
      height: 1,  
      width: "100%",  
      backgroundColor: "#999999",  
    },
    border: {
      borderColor: "#eee", borderBottomWidth: 1
    },
  });
  
 const buttons = StyleSheet.create({
   primary: {
    marginRight:40,
    marginLeft:40,
    marginTop:10,
    paddingTop:10,
    paddingBottom:10,
    backgroundColor:'#DEDEDE',
    borderRadius:10,
    borderWidth: 1,
    borderColor: '#222222'
   }
 })
  
export { styles, buttons } 